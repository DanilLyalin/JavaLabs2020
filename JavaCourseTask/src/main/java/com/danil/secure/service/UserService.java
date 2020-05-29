package com.danil.secure.service;

import com.danil.secure.entity.CurrentUser;

public interface UserService {

    CurrentUser getUser(String login);

}
