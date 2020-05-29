package com.danil.secure.service;

import com.danil.secure.entity.AutoPersonnelEntity;
import com.danil.secure.entity.CurrentUser;
import com.danil.secure.entity.enums.UserRoleEnum;
import com.danil.secure.utils.HibernateUtils;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Override
    public CurrentUser getUser(String login) {
       CurrentUser user = null;

        Session session = HibernateUtils.sessionFactory.getCurrentSession();
        try {
            session.getTransaction().begin();

            Query query = session.createQuery("from AutoPersonnelEntity where login = :paramName");
            query.setParameter("paramName", login);
            List list = query.list();
            AutoPersonnelEntity currentUser = (AutoPersonnelEntity)list.get(0);

            Integer id = currentUser.getId();
            String username = login;
            String password = currentUser.getPassword();
            boolean enabled = true;
            boolean accountNonExpired = true;
            boolean credentialsNonExpired = true;
            boolean accountNonLocked = true;
            List<GrantedAuthority> authorities = new LinkedList<>();
            if(username.equals("admin"))
                authorities.add(new SimpleGrantedAuthority(UserRoleEnum.ADMIN.name()));
            else
                authorities.add(new SimpleGrantedAuthority(UserRoleEnum.USER.name()));
            user = new CurrentUser(username, password, enabled, accountNonExpired, credentialsNonExpired,
                    accountNonLocked, authorities);
            user.setLogin(currentUser.getLogin());
            user.setPassword(currentUser.getPassword());
            user.setId(currentUser.getId());
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
        }
        return user;
    }

}
