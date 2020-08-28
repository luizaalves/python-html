import flask
from flask import Flask, render_template, session, request,Markup
from flask_bootstrap import Bootstrap
from flask_nav import Nav
from flask_nav.elements import Navbar, View, Text
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import create_engine, func,update
from sqlalchemy.orm import sessionmaker,mapper
from werkzeug.security import generate_password_hash, check_password_hash

from forms import LoginForm, AvaliacaoForm

SECRET_KEY = 'string com texto aleatorio'

app = Flask(__name__)
app.secret_key = SECRET_KEY

bootstrap = Bootstrap(app)
nav = Nav()
nav.init_app(app)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///ddl-dml'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
engine = create_engine("sqlite:///ddl-dml")
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
usuario_resposta_table = db.Table('usuario_resposta', db.metadata,
    db.Column('resposta_id', db.Integer, db.ForeignKey('resposta.id_resposta')),
    db.Column('usuario_id', db.Integer, db.ForeignKey('usuario.id_usuario')),
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
    respostas = db.relationship("Respostas", secondary=usuario_resposta_table)

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

class Respostas(db.Model):
    __tablename__ = 'resposta'
    id_resposta = db.Column(db.Integer,primary_key=True, unique=True, autoincrement=True, nullable=False)
    count = db.Column(db.Integer)
    usuario_id=db.Column(db.Integer, db.ForeignKey('usuario.id_usuario'))
    usuario = db.relationship('Usuario', secondary=usuario_resposta_table)
    avaliacao_id = db.Column(db.Integer, db.ForeignKey('avaliacao.id_avaliacao'))
    disciplina_id = db.Column(db.Integer, db.ForeignKey('disciplina.id_disciplina'))

@nav.navigation()
def menu():
    menu = Navbar('Projeto 02')
    if session.get('logado'):
        usuario_logado = Usuario.query.filter_by(id_usuario=session.get('usuario')).first_or_404()
        menu.items.append(View('Disciplinas', 'listar_disciplinas'))
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
        usuario = Usuario.query.filter_by(email=form.email.data).first()
        if usuario is not None:
            if usuario.senha==form.senha.data:
                session['logado']=True
                session['usuario']=usuario.id_usuario
                return flask.redirect(flask.url_for('listar_disciplinas'))
        else:
            return render_template('login.html', form=form)
    session['usuario'] = None
    session['logado'] = False
    return render_template('login.html', form=form)

@app.route('/disciplinas')
def listar_disciplinas():
    if session.get('logado'):
        session['avaliacoes']=False
        id_user = session.get('usuario')
        if id_user is not None :
            usuario = Usuario.query.filter_by(id_usuario=id_user).first()
            if usuario is not None:
                respostas = Respostas.query.filter_by(usuario_id=usuario.id_usuario).all()
                return render_template('logado/disciplinas.html',usuario=usuario,respostas=respostas)
    session['usuario'] = None
    session['logado'] = False
    return flask.redirect(flask.url_for('login'))

@app.route('/avaliacao',methods=['GET', 'POST'])
def avaliacao():
    if session.get('logado'):
        session['avaliacoes']=False
        id_usuario = session.get('usuario')
        usuario = Usuario.query.filter_by(id_usuario=id_usuario).first()
        id_avaliacao = request.args.get('id_avaliacao')
        disciplina = Disciplinas.query.filter(Disciplinas.avaliacoes.any(id_avaliacao=id_avaliacao)).first()
        if disciplina in usuario.disciplinas:
            avaliacao = Avaliacoes.query.filter_by(id_avaliacao=id_avaliacao).first()
            av = AvaliacaoForm()
            if request.method=='POST':
                sessionSQL = Session()
                resposta_usuario_q1 = sessionSQL.query(Questoes).filter_by(alternativa_id=av.q1.data).first()
                resposta_usuario_q2 = sessionSQL.query(Questoes).filter_by(alternativa_id=av.q2.data).first()
                resposta_usuario_q3 = sessionSQL.query(Questoes).filter_by(alternativa_id=av.q3.data).first()
                questoes_certas=0
                if resposta_usuario_q1 is not None:
                    questoes_certas=questoes_certas+1
                if resposta_usuario_q2 is not None:
                    questoes_certas=questoes_certas+1
                if resposta_usuario_q3 is not None:
                    questoes_certas=questoes_certas+1
                #add na tabela
                resposta=Respostas()
                resposta.disciplina_id=disciplina.id_disciplina
                resposta.usuario_id=usuario.id_usuario
                resposta.avaliacao_id=avaliacao.id_avaliacao
                resposta.count = questoes_certas
                sessionSQL.add(resposta)
                sessionSQL.commit()
                sessionSQL.close()
                respostas = Respostas.query.filter_by(usuario_id=id_usuario).all()
                session['avaliacoes'] = True
                return render_template('logado/avaliacoes.html',disciplina=disciplina,respostas=respostas)

            av.q1.label = Markup(avaliacao.questoes[0].enunciado)
            av.q1.choices = [(alternativa.id_alternativa, alternativa.alternativa) for alternativa in avaliacao.questoes[0].alternativas]

            av.q2.label = Markup(avaliacao.questoes[1].enunciado)
            av.q2.choices = [(alternativa.id_alternativa, alternativa.alternativa) for alternativa in
                                        avaliacao.questoes[1].alternativas]

            av.q3.label = Markup(avaliacao.questoes[2].enunciado)
            av.q3.choices = [(alternativa.id_alternativa, alternativa.alternativa) for alternativa in
                                        avaliacao.questoes[2].alternativas]
            return render_template('logado/avaliacao.html',avaliacao=avaliacao,form=av)
    session['usuario'] = None
    session['logado'] = False
    return flask.redirect(flask.url_for('login'))

@app.route('/avaliacoes')
def listar_avaliacoes():
    if session.get('logado'):
        session['avaliacoes'] = True
        id_usuario = session.get('usuario')
        usuario = Usuario.query.filter_by(id_usuario=id_usuario).first()
        print(request.args.get('id_disciplina'))
        nome_disciplina = request.args.get('disciplina')
        if nome_disciplina is None:
            nome_disciplina = session['nome_disciplina']
        disciplina = Disciplinas.query.filter_by(nome=nome_disciplina).first()
        if disciplina in usuario.disciplinas:
            respostas = Respostas.query.filter_by(usuario_id=id_usuario).all()
            return render_template('logado/avaliacoes.html',disciplina=disciplina,respostas=respostas)
    session['usuario'] = None
    session['logado'] = False
    return flask.redirect(flask.url_for('login'))

@app.route('/sair')
def sair():
    if session.get('logado'):
        session['usuario'] = None
        session['logado'] = False
    return flask.redirect(flask.url_for('inicial'))

@app.route('/')
def inicial():
    if session.get('logado'):
        return flask.redirect(flask.url_for('listar_disciplinas'))
    session['usuario'] = None
    session['logado'] = False
    return flask.redirect(flask.url_for('login'))

if __name__ == '__main__':
    app.run()
