from flask import Flask, request, jsonify, blueprints
from Collect_List_Controller import Collect_List_bp
from UserController import user_bp
app = Flask(__name__)
app.register_blueprint(Collect_List_bp, url_prefix='')
app.register_blueprint(user_bp, url_prefix='')


@app.route('/login', methods=['POST'])
def receive_data():
    data = request.json #取得request到的json檔
    if data:
        print(f"Received data: {data}")
    else:
        print("No data received")
    return jsonify(success=True, received=data), 200

if __name__ == '__main__': 
    app.run(host='0.0.0.0', port=8080)
