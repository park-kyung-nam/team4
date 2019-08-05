package dev.mvc.delivery;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;



@Component("dev.mvc.delivery.DeliveryProc")
public class DeliveryProc implements DeliveryProcInter {
    @Autowired
    private DeliveryDAOInter deliveryDAO;
    @Override
    public int create(DeliveryVO deliveryVO) {
        int create = deliveryDAO.create(deliveryVO);
        return create;
    }
    
}