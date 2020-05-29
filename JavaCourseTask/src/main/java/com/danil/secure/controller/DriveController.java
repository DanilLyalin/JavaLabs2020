package com.danil.secure.controller;

import com.danil.secure.entity.AutoEntity;
import com.danil.secure.entity.AutoPersonnelEntity;
import com.danil.secure.entity.JournalEntity;
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
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/drive")
public class DriveController {

    @RequestMapping(method = RequestMethod.GET)
    public String mainPage(Model model) {
        return "drive";
    }

    @RequestMapping(value = "/start", method = RequestMethod.POST)
    public @ResponseBody
    ResponseEntity start(int car_id, int route_id,int driver_id) {
        JournalEntity journal = new JournalEntity();
        List<JournalEntity> check = null;
        List<AutoEntity> user_autos = null;
        journal.setAutoId(car_id);

        journal.setRouteId(route_id);

        Date date = new Date(System.currentTimeMillis());
        journal.setTimeIn(new Timestamp(date.getTime()));
        journal.setTimeOut(new Timestamp(date.getTime() - 100000));
        Session session = HibernateUtils.sessionFactory.getCurrentSession();

        try {
            session.getTransaction().begin();
            Query query = session.createQuery("from AutoEntity where personnelId= " + driver_id);
            user_autos = query.list();
            session.getTransaction().commit();
            session.close();
            for(int i = 0;i<user_autos.size();i++){
                session = HibernateUtils.sessionFactory.getCurrentSession();
                session.getTransaction().begin();
                Query query2 = session.createQuery("from JournalEntity where autoId= "+ user_autos.get(i).getId());
                List<JournalEntity> carTrips = query2.list();
                session.close();
                for(int j = 0;j<carTrips.size();j++){
                    if(carTrips.get(j).getTimeIn().getTime() - carTrips.get(j).getTimeOut().getTime() > 0) {
                        return new ResponseEntity(HttpStatus.NOT_ACCEPTABLE);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
        }
        try {
            session = HibernateUtils.sessionFactory.getCurrentSession();
            session.getTransaction().begin();
            session.save(journal);
            session.getTransaction().commit();
            session.close();
        } catch (Exception e) {
            return new ResponseEntity(HttpStatus.NOT_ACCEPTABLE);
        }
        return new ResponseEntity(HttpStatus.OK);
    }

    @RequestMapping(value = "/finish", method = RequestMethod.POST)
    public @ResponseBody ResponseEntity finish(int car_id, int route_id) {
        List<JournalEntity> journal = null;
        Session session = HibernateUtils.sessionFactory.getCurrentSession();
        try {
            Date date = new Date(System.currentTimeMillis());
            session.getTransaction().begin();
            Query query = session.createQuery("from JournalEntity where autoId= " + car_id +" and routeId= "+route_id);
            journal = query.list();
            for(int i = 0 ; i < journal.size(); i++) {
                if(journal.get(i).getTimeIn().getTime() - journal.get(i).getTimeOut().getTime() > 0) {
                    journal.get(i).setTimeOut(new Timestamp(date.getTime()));
                    session.save(journal.get(i));
                }
            }
            session.getTransaction().commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity(HttpStatus.NOT_ACCEPTABLE);
        }
        return new ResponseEntity(HttpStatus.OK);
    }

}
