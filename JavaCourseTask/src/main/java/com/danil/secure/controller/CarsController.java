package com.danil.secure.controller;

import com.danil.secure.entity.AutoEntity;
import com.danil.secure.utils.HibernateUtils;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/cars")
public class CarsController {

    @RequestMapping(method = RequestMethod.GET)
    public String mainPage(Model model) {
        return "cars";
    }

    @RequestMapping(value = "/addcar",method = RequestMethod.GET)
    public String addPage(Model model) {
        return "addcar";
    }

    @RequestMapping(value = "/deletecar",method = RequestMethod.GET)
    public String delPage(Model model) {
        return "deletecar";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public @ResponseBody ResponseEntity addCar(AutoEntity auto) {
        if(auto.getNum().matches("[a-z]{1}[0-9]{3}[a-z]{2}") && auto.getNum().length() == 6) {
            Session session = HibernateUtils.sessionFactory.getCurrentSession();
            try {
                session.getTransaction().begin();
                session.save(auto);
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
    public @ResponseBody ResponseEntity delCar(String auto_id) {
        Session session = HibernateUtils.sessionFactory.getCurrentSession();
        int rowCount;
        try {
            session.getTransaction().begin();
            Query query = session.createQuery("DELETE FROM AutoEntity WHERE id = " + auto_id);
            rowCount = query.executeUpdate();
            session.close();
        } catch (Exception e) {
            return new ResponseEntity(HttpStatus.NOT_ACCEPTABLE);
        }
        if (rowCount == 0)
            return new ResponseEntity(HttpStatus.NOT_ACCEPTABLE);
        return new ResponseEntity(HttpStatus.OK);
    }

    @RequestMapping(value = "/get/bydriver", method = RequestMethod.GET)
    @ResponseBody
    public String getByDriver(String driver_id){

        List<AutoEntity> autos = null;
        Session session = HibernateUtils.sessionFactory.getCurrentSession();
        try {
            session.getTransaction().begin();
            Query query = session.createQuery("from AutoEntity where personnelId = "+driver_id);
            autos = query.list();
            session.getTransaction().commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
        }
        return new Gson().toJson(autos);
    }

    @RequestMapping(value = "/get/userCars", method = RequestMethod.GET)
    @ResponseBody
    public String getUserCars(String user_id){

        List<AutoEntity> autos = null;
        Session session = HibernateUtils.sessionFactory.getCurrentSession();
        try {
            session.getTransaction().begin();
            Query query = session.createQuery("from AutoEntity where personnelId = " + user_id);
            autos = query.list();
            session.getTransaction().commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
        }
        return new Gson().toJson(autos);
    }

    @RequestMapping(value = "/get/owner", method = RequestMethod.GET)
    @ResponseBody
    public String getOwner(String auto_id){
        List<AutoEntity> autos = null;
        List<AutoEntity> owner = null;
        Session session = HibernateUtils.sessionFactory.getCurrentSession();
        try {
            session.getTransaction().begin();
            Query query = session.createQuery("from AutoEntity where id = " + auto_id);
            autos = query.list();
            Query query2 = session.createQuery("from AutoPersonnelEntity where id = " + autos.get(0).getPersonnelId());
            owner = query2.list();
            session.getTransaction().commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
        }
        return new Gson().toJson(owner);
    }

    @RequestMapping(value = "/get/all", method = RequestMethod.GET)
    @ResponseBody
    public String getCars(){

        List<AutoEntity> autos = null;
        Session session = HibernateUtils.sessionFactory.getCurrentSession();
        try {
            session.getTransaction().begin();
            Query query = session.createQuery("from AutoEntity");
            autos = query.list();
            session.getTransaction().commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
        }
        return new Gson().toJson(autos);
    }
}