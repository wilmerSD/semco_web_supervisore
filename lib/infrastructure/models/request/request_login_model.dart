class RequestLoginModel {
    String? username;
    String? password;

    RequestLoginModel({
        this.username,
        this.password,
    });

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
    };
}