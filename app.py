import flask
from flask import Flask, render_template, session, request
from flask_bootstrap import Bootstrap
from flask_nav import Nav
from flask_nav.elements import Navbar, View, Text
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from werkzeug.security import generate_password_hash, check_password_hash
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import DataRequired

SECRET_KEY = 'string com texto aleatorio'

app = Flask(__name__)
app.secret_key = SECRET_KEY

bootstrap = Bootstrap(app)
nav = Nav()
nav.init_app(app)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///mydb'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
engine = create_engine("sqlite:///mydb")
Session = sessionmaker(bind=engine)

usuario_disciplina_table = db.Table('usuario_disciplina', db.metadata,
     db.Column('usuario_id', db.Integer, db.ForeignKey('usuario.id_usuario')),
     db.Column('disciplina_id', db.Integer, db.ForeignKey('disciplina.id_disciplina'))
 )
avaliacao_questao_table = db.Table('avaliacao_questao', db.metadata,
     db.Column('avaliacao_id', db.Integer, db.ForeignKey('avaliacao.id_avaliacao')),
     db.Column('questao_id', db.Integer, db.ForeignKey('questao.id_questao'))
 )
disciplina_avaliacao_table = db.Table('disciplina_avaliacao', db.metadata,
    db.Column('avaliacao_id', db.Integer, db.ForeignKey('avaliacao.id_avaliacao')),
    db.Column('disciplina_id', db.Integer, db.ForeignKey('disciplina.id_disciplina'))
 )
usuario_avaliacao_table = db.Table('usuario_avaliacao', db.metadata,
    db.Column('avaliacao_id', db.Integer, db.ForeignKey('avaliacao.id_avaliacao')),
    db.Column('usuario_id', db.Integer, db.ForeignKey('usuario.id_usuario'))
 )
questao_alternativa_table = db.Table('questao_alternativa', db.metadata,
     db.Column('alternativa_id', db.Integer, db.ForeignKey('alternativa.id_alternativa')),
     db.Column('questao_id', db.Integer, db.ForeignKey('questao.id_questao'))
 )

class Usuario(db.Model):
    __tablename__= 'usuario'
    id_usuario=db.Column(db.Integer,primary_key=True, unique=True, autoincrement=True, nullable=False)
    nome=db.Column(db.String,nullable=False)
    email=db.Column(db.String(40), nullable=False)
    senha=db.Column(db.String(200), nullable=False)
    disciplinas = db.relationship("Disciplinas",
                            secondary=usuario_disciplina_table)
    avaliacoes = db.relationship("Avaliacoes", secondary=usuario_avaliacao_table)

    def __init__(self,**kwargs):
        super().__init__(**kwargs)
        self.email=kwargs.pop('email')
        self.senha=generate_password_hash(kwargs.pop('senha'))

    def set_password(self,senha):
        self.senha=generate_password_hash(senha)

    def check_password(self,senha_digitada):
        self.check_password(check_password_hash(self.senha,senha_digitada))

class Disciplinas(db.Model):
    __tablename__ = 'disciplina'
    id_disciplina = db.Column(db.Integer,primary_key=True, unique=True, autoincrement=True, nullable=False)
    nome = db.Column(db.String, nullable=False)
    avaliacoes = db.relationship("Avaliacoes",
                                  secondary=disciplina_avaliacao_table)
class Avaliacoes(db.Model):
    __tablename__ = 'avaliacao'
    id_avaliacao = db.Column(db.Integer,primary_key=True, unique=True, autoincrement=True, nullable=False)
    nome = db.Column(db.String, nullable=False)
    questoes = db.relationship('Questoes',secondary=avaliacao_questao_table)

class Questoes(db.Model):
    __tablename__ = 'questao'
    id_questao = db.Column(db.Integer,primary_key=True, unique=True, autoincrement=True, nullable=False)
    enunciado = db.Column(db.String, nullable=False)
    alternativa_id = db.Column(db.Integer, db.ForeignKey('alternativa.id_alternativa'))
    alternativas = db.relationship('Alternativas',secondary=questao_alternativa_table)

class Alternativas(db.Model):
    __tablename__ = 'alternativa'
    id_alternativa = db.Column(db.Integer,primary_key=True, unique=True, autoincrement=True, nullable=False)
    alternativa = db.Column(db.String, nullable=False)

class LoginForm(FlaskForm):
    email = StringField('Usuário', validators=[DataRequired('Campo obrigatório')])
    senha = PasswordField('Senha', validators=[DataRequired('Campo obrigatório')])
    submit = SubmitField('Entrar')

@nav.navigation()
def menu():
    menu = Navbar('Projeto 02')
    if session.get('logado'):
        usuario_logado = Usuario.query.filter_by(id_usuario=session.get('usuario')).first_or_404()
        menu.items.append(View('Disciplinas', 'listar_disciplinas'))
        if(session['avaliacoes']):
            menu.items.append(View('Avaliações', 'listar_avaliacoes'))
        menu.items.append(Text('     '))
        menu.items.append(Text('Olá, '+usuario_logado.nome))
        menu.items.append(View('Sair', 'sair'))
        return menu
    menu.items = [View('Início', 'inicial')]
    return menu

@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        usuario = Usuario.query.filter_by(email=form.email.data).first_or_404()
        if usuario is not None:
            if usuario.senha==form.senha.data:
                session['logado']=True
                session['usuario']=usuario.id_usuario
                return flask.redirect(flask.url_for('listar_disciplinas'))
    return render_template('login.html', form=form)

@app.route('/disciplinas')
def listar_disciplinas():
    if session.get('logado'):
        session['avaliacoes']=False
        id_user = session.get('usuario')
        if id_user is not None :
            usuario = Usuario.query.filter_by(id_usuario=id_user).first()
            if usuario is not None:
                return render_template('logado/disciplinas.html',disciplinas=usuario.disciplinas,count=len(usuario.avaliacoes))
    return flask.redirect(flask.url_for('login'))

@app.route('/avaliacao')
def avaliacao():
    if session.get('logado'):
        session['avaliacao'] = True
        avaliacao_id = str(request.args.get('id_avaliacao'))
        avaliacao = Avaliacoes.query.filter_by(id_avaliacao=avaliacao_id).first()
        return render_template('logado/avaliacao.html',avaliacao=avaliacao,questoes=avaliacao.questoes)
    return flask.redirect(flask.url_for('login'))

@app.route('/avaliacoes')
def listar_avaliacoes():
    if session.get('logado'):
        session['avaliacoes'] = True
        disciplina_id = str(request.args.get('id_disciplina'))
        disciplina=Disciplinas.query.filter_by(id_disciplina=disciplina_id).first()
        return render_template('logado/avaliacoes.html',avaliacoes=disciplina.avaliacoes,disciplina=disciplina)
    return flask.redirect(flask.url_for('login'))

@app.route('/sair')
def sair():
    if session.get('logado'):
        session['usuario'] = None
        session['logado'] = False
    return flask.redirect(flask.url_for('inicial'))

@app.route('/')
def inicial():
    session['logado'] = False
    if session.get('logado'):
        return flask.redirect(flask.url_for('listar_disciplinas'))
    return flask.redirect(flask.url_for('login'))

if __name__ == '__main__':
    app.run()
