from flask import Flask, jsonify, request
from flask_mysqldb import MySQL
import MySQLdb.cursors
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# MySQL configurations
app.config['MYSQL_HOST'] = 'ip-addre'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'password'
app.config['MYSQL_DB'] = 'test'

mysql = MySQL(app)

@app.route('/')
def is_alive():
    return jsonify('live')


@app.route('/api/msg/<string:msg>', methods=['POST'])
def msg_post_api(msg):
    print(f"msg_post_api with message: {msg}")
    # TODO: store msg in DB and return identifier
    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO messages (msg) VALUES (%s)", (msg,))
    mysql.connection.commit()
    msg_id = cursor.lastrowid
    cursor.close()
    return jsonify({'msg_id': msg_id})


@app.route('/api/msg/<int:msg_id>', methods=['GET'])
def msg_get_api(msg_id):
    print(f"msg_get_api > msg_id = {msg_id}")
    # TODO: get msg from DB and return it
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT msg FROM messages WHERE msg_id = %s", (msg_id,))
    message = cursor.fetchone()
    cursor.close()
    if message:
        return jsonify({'msg': message['msg']})
    else:
        return jsonify({'error': 'Message not found'}), 404
    return jsonify({'msg': msg})


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
