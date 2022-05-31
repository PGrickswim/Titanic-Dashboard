import flask
from .commands import create_tables
from .app import main
from .extensions import db


def create_app(config_file='settings.py'):
    app = flask.Flask(__name__)

    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///postgres:paradise22@localhost:5432/titanic_project'

    db.init_app(app)

    app.config.from_pyfile(config_file)

    app.register_blueprint(main)

    app.cli.add_command(create_tables)

    return app
