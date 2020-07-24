from flask import Flask, render_template
from flask_bootstrap import Bootstrap
from flask_nav import Nav
from flask_nav.elements import Navbar, View, Subgroup, Link

app = Flask(__name__)
bootstrap = Bootstrap(app)
nav = Nav()
nav.init_app(app)

@nav.navigation()
def menunavbar():
    menu = Navbar('Terceiro Lab')
    menu.items = [View('Início','inicial'), View('Login','login')]
    menu.items.append(Link('Ajuda','https://www.google.com.br'))
    return menu

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)
