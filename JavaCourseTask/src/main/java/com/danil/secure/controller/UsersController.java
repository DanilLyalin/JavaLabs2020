package com.danil.secure.controller;

import com.danil.secure.entity.AutoEntity;
import com.danil.secure.entity.AutoPersonnelEntity;
import com.danil.secure.utils.HibernateUtils;
import com.google.gson.Gson;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.xml.bind.DatatypeConverter;
import java.security.MessageDigest;
import java.util.List;

@Controller
@RequestMapping("/users")
public class UsersController {

    @RequestMapping(method = RequestMethod.GET)
    public String mainPage(Model model) {
        return "users";
    }

    @RequestMapping(value = "/adduser",method = RequestMethod.GET)
    public String addPage(Model model) {
        return "adduser";
    }

    @RequestMapping(value = "/deleteuser",method = RequestMethod.GET)
    public String delPage(Model model) {
        return "deleteuser";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public @ResponseBody ResponseEntity addUser(AutoPersonnelEntity user) {
        if (user.getFirstName().matches("[a-zA-Z]+") && user.getLastName().matches("[a-zA-Z]+") && user.getFatherName().matches("[a-zA-Z]+") && user.getPassword().length() > 8){
            String rawPas = user.getPassword();
            String sha1Pas = null;
            try {
                MessageDigest msdDigest = MessageDigest.getInstance("SHA-1");
                msdDigest.update(rawPas.getBytes("UTF-8"), 0, rawPas.length());
                sha1Pas = DatatypeConverter.printHexBinary(msdDigest.digest());
            } catch (Exception e) {
                return new ResponseEntity(HttpStatus.NOT_ACCEPTABLE);
            }
            user.setPassword(sha1Pas.toLowerCase());
            Session session = HibernateUtils.sessionFactory.getCurrentSession();
            try {
                session.getTransaction().begin();
                session.save(user);
                session.getTransaction().commit();
                session.close();
            } catch (Exception e) {
                return new ResponseEntity(HttpStatus.NOT_ACCEPTABLE);
            }
            return new ResponseEntity(HttpStatus.OK);
        }
        else
            return new ResponseEntity(HttpStatus.NOT_ACCEPTABLE);
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public @ResponseBody
    ResponseEntity addCar(String user_id) {
        Session session = HibernateUtils.sessionFactory.getCurrentSession();
        int rowCount;
        try {
            session.getTransaction().begin();
            Query query = session.createQuery("DELETE FROM AutoPersonnelEntity WHERE id = " + user_id);
            rowCount = query.executeUpdate();
            session.close();
        } catch (Exception e) {
            return new ResponseEntity(HttpStatus.NOT_ACCEPTABLE);
        }
        if (rowCount == 0)
            return new ResponseEntity(HttpStatus.NOT_ACCEPTABLE);
        return new ResponseEntity(HttpStatus.OK);
    }

    @RequestMapping(value = "/get/ByLogin", method = RequestMethod.GET)
    @ResponseBody
    public String getLogin(String login){
        List<AutoPersonnelEntity> users = null;
        Session session = HibernateUtils.sessionFactory.getCurrentSession();
        try {
            session.getTransaction().begin();
            Query query = session.createQuery("from AutoPersonnelEntity where login = \'"+login+"\'");
            users = query.list();
            session.getTransaction().commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
        }
        return new Gson().toJson(users);
    }

    @RequestMapping(value = "/get/all", method = RequestMethod.GET)
    @ResponseBody
    public String getUsers(){

        List<AutoPersonnelEntity> users = null;
        Session session = HibernateUtils.sessionFactory.getCurrentSession();
        try {
            session.getTransaction().begin();
            Query query = session.createQuery("from AutoPersonnelEntity");
            users = query.list();
            session.getTransaction().commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
        }
        return new Gson().toJson(users);
    }
}
