package com.danil.secure.controller;

import com.danil.secure.entity.CurrentUser;
import com.danil.secure.utils.HibernateUtils;
import com.google.gson.Gson;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.danil.secure.entity.RoutesEntity;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/routes")
public class RoutesController {

    @RequestMapping(method = RequestMethod.GET)
    public String mainPage(Model model) {
        return "routes";
    }

    @RequestMapping(value = "/addroute",method = RequestMethod.GET)
    public String addPage(Model model) {
        return "addroute";
    }

    @RequestMapping(value = "/deleteroute",method = RequestMethod.GET)
    public String delPage(Model model) {
        return "deleteroute";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public @ResponseBody
    ResponseEntity addRoute(RoutesEntity route) {
        Session session = HibernateUtils.sessionFactory.getCurrentSession();
        try {
            session.getTransaction().begin();
            session.save(route);
            session.getTransaction().commit();
            session.close();
        } catch (Exception e) {
            return new ResponseEntity(HttpStatus.NOT_ACCEPTABLE);
        }
        return new ResponseEntity(HttpStatus.OK);
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public @ResponseBody ResponseEntity deleteRoute(String route_id) {
        Session session = HibernateUtils.sessionFactory.getCurrentSession();
        int rowCount;
        try {
            session.getTransaction().begin();
            Query query = session.createQuery("DELETE FROM RoutesEntity WHERE id = " + route_id);
            rowCount = query.executeUpdate();
            session.close();
        } catch (Exception e) {
            return new ResponseEntity(HttpStatus.NOT_ACCEPTABLE);
        }
        if (rowCount == 0)
            return new ResponseEntity(HttpStatus.NOT_ACCEPTABLE);
        return new ResponseEntity(HttpStatus.OK);
    }

    @RequestMapping(value = "/get/all", method = RequestMethod.GET)
    @ResponseBody
    public String getRoutes(){

        List<RoutesEntity> routes = null;
        Session session = HibernateUtils.sessionFactory.getCurrentSession();
        try {
            session.getTransaction().begin();
            Query query = session.createQuery("from RoutesEntity");
            routes = query.list();
            session.getTransaction().commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
        }

        return new Gson().toJson(routes);
    }
}
