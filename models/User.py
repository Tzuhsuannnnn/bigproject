import json

class User:
    def __init__(self, name, email, birth, password, sex):
        self.name = name
        self.email = email
        self.birth = birth
        self.password = password
        self.sex = sex
        self.id = None
    
    def set_id(self, id):
        self.id = id

    def get_id(self):
        return self.id

    def update_name(self, helper, new_name):
        self.name = new_name
        return helper.update_user_field(self.id, 'Name', new_name)

    def update_password(self, helper, new_pass):
        self.password = new_pass
        return helper.update_user_field(self.id, 'Password', new_pass)

    def get_user_data(self):
        user_data = {
            "name": self.name,
            "email": self.email,
            "password": self.password,
            "birthday": self.birth,
            "sex": self.sex
        }
        return json.dumps(user_data)

    #login
    #######可註解
    @staticmethod
    def get_User_by_Email_and_Password(email, password):
        pass
    # login 寫在helper



