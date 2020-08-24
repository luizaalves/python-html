from flask_wtf import FlaskForm, Form
from wtforms import StringField, PasswordField, SubmitField, RadioField, validators, SelectField
from wtforms.validators import DataRequired, Required

class AvaliacaoForm(FlaskForm):
    q1 = RadioField('Label', choices=[])
    q2 = RadioField('Label', choices=[])
    q3 = RadioField('Label', choices=[])
    submit = SubmitField('Enviar')

class LoginForm(FlaskForm):
    email = StringField('Usuário', validators=[DataRequired('Campo obrigatório')])
    senha = PasswordField('Senha', validators=[DataRequired('Campo obrigatório')])
    submit = SubmitField('Entrar')
