package com.sgrh.dao;

import com.conf.component.Users;

public interface UserDetailsDao {
	Users findUserByName(String userName);
}
