from sqlalchemy import Column, Integer, String, Table, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from werkzeug.security import generate_password_hash, check_password_hash


Base = declarative_base()

usuario_disciplina_table = Table('usuario_disciplina', Base.metadata,
     Column('usuario_id', Integer, ForeignKey('usuario.id_usuario')),
     Column('disciplina_id', Integer, ForeignKey('disciplina.id_disciplina'))
 )
usuario_avaliacao_table =Table('usuario_avaliacao', Base.metadata,
    Column('avaliacao_id', Integer, ForeignKey('avaliacao.id_avaliacao')),
    Column('usuario_id', Integer, ForeignKey('usuario.id_usuario'))
 )
avaliacao_questao_table = Table('avaliacao_questao', Base.metadata,
     Column('avaliacao_id', Integer, ForeignKey('avaliacao.id_avaliacao')),
     Column('questao_id', Integer, ForeignKey('questao.id_questao'))
 )
disciplina_avaliacao_table = Table('disciplina_avaliacao', Base.metadata,
    Column('avaliacao_id', Integer, ForeignKey('avaliacao.id_avaliacao')),
    Column('disciplina_id', Integer, ForeignKey('disciplina.id_disciplina'))
 )
questao_alternativa_table = Table('questao_alternativa', Base.metadata,
     Column('alternativa_id', Integer, ForeignKey('alternativa.id_alternativa')),
     Column('questao_id', Integer, ForeignKey('questao.id_questao'))
 )
class Usuario(Base):
    __tablename__= 'usuario'
    id_usuario=Column(Integer,primary_key=True, unique=True, autoincrement=True, nullable=False)
    nome=Column(String,nullable=False)
    email=Column(String(40), nullable=False)
    senha=Column(String(200), nullable=False)
    disciplinas = relationship("Disciplinas",
                            secondary=usuario_disciplina_table)
    avaliacoes = relationship("Avaliacoes", secondary=usuario_avaliacao_table)

    def __init__(self,**kwargs):
        super().__init__(**kwargs)
        self.email=kwargs.pop('email')
        self.senha=generate_password_hash(kwargs.pop('senha'))

    def set_password(self,senha):
        self.senha=generate_password_hash(senha)

    def check_password(self,senha_digitada):
        self.check_password(check_password_hash(self.senha,senha_digitada))

    @classmethod
    def find_by_id(cls, session, id):
        return session.query(cls).filter_by(id_usuario=id).first()

    @classmethod
    def find_by_email(cls, session, email):
        return session.query(cls).filter_by(email=email).first()

class Disciplinas(Base):
    __tablename__ = 'disciplina'
    id_disciplina = Column(Integer,primary_key=True, unique=True, autoincrement=True, nullable=False)
    nome = Column(String, nullable=False)
    avaliacoes = relationship("Avaliacoes",
                                  secondary=disciplina_avaliacao_table)
class Avaliacoes(Base):
    __tablename__ = 'avaliacao'
    id_avaliacao = Column(Integer,primary_key=True, unique=True, autoincrement=True, nullable=False)
    nome = Column(String, nullable=False)
    questoes = relationship('Questoes',secondary=avaliacao_questao_table)

class Questoes(Base):
    __tablename__ = 'questao'
    id_questao = Column(Integer,primary_key=True, unique=True, autoincrement=True, nullable=False)
    enunciado = Column(String, nullable=False)
    alternativa_id = Column(Integer, ForeignKey('alternativa.id_alternativa'))
    alternativas = relationship('Alternativas',secondary=questao_alternativa_table)

class Alternativas(Base):
    __tablename__ = 'alternativa'
    id_alternativa = Column(Integer,primary_key=True, unique=True, autoincrement=True, nullable=False)
    alternativa = Column(String, nullable=False)
