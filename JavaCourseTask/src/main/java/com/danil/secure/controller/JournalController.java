package com.danil.secure.controller;

import com.danil.secure.entity.JournalEntity;
import com.danil.secure.entity.RoutesEntity;
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

import java.util.List;

@Controller
@RequestMapping("/journal")
public class JournalController {

    @RequestMapping(method = RequestMethod.GET)
    public String mainPage(Model model) {
        return "journal";
    }


    @RequestMapping(value = "/deletefromjournal",method = RequestMethod.GET)
    public String delPage(Model model) {
        return "deletefromjournal";
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public @ResponseBody ResponseEntity deleteLine(String line_id) {
        Session session = HibernateUtils.sessionFactory.getCurrentSession();
        int rowCount;
        try {
            session.getTransaction().begin();
            Query query = session.createQuery("DELETE FROM JournalEntity WHERE id = " + line_id);
            rowCount = query.executeUpdate();
            session.close();
        } catch (Exception e) {
            return new ResponseEntity(HttpStatus.NOT_ACCEPTABLE);
        }
        if (rowCount == 0)
            return new ResponseEntity(HttpStatus.NOT_ACCEPTABLE);
        return new ResponseEntity(HttpStatus.OK);
    }

    @RequestMapping(value = "/clear", method = RequestMethod.POST)
    public @ResponseBody ResponseEntity clearJournal() {
        Session session = HibernateUtils.sessionFactory.getCurrentSession();
        int rowCount;
        try {
            session.getTransaction().begin();
            Query query = session.createQuery("DELETE FROM JournalEntity WHERE id > 0");
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

        List<JournalEntity> journal = null;
        Session session = HibernateUtils.sessionFactory.getCurrentSession();
        try {
            session.getTransaction().begin();
            Query query = session.createQuery("from JournalEntity");
            journal = query.list();
            session.getTransaction().commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
        }

        return new Gson().toJson(journal);
    }
}
