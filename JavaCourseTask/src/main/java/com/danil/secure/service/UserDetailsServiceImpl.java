package com.danil.secure.service;

import com.danil.secure.entity.CurrentUser;
import com.danil.secure.entity.enums.UserRoleEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Set;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserService userService;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        CurrentUser currentUser = userService.getUser(email);
        Set<GrantedAuthority> roles = new HashSet();
        if(email.equals("admin"))
            roles.add(new SimpleGrantedAuthority(UserRoleEnum.ADMIN.name()));
        else
            roles.add(new SimpleGrantedAuthority(UserRoleEnum.USER.name()));
        UserDetails userDetails =
                new org.springframework.security.core.userdetails.User(currentUser.getLogin(), currentUser.getPassword(), roles);

        return userDetails;
    }

}
