package com.service;

import com.dao.SelectDao;
import com.pojo.AnimalInfo;
import com.utils.WriteToFileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

@Service("selectService")
public class SelectServiceImpl implements SelectService{


    private Logger logger=Logger.getLogger(SelectServiceImpl.class);
    HttpServletResponse resp;
    @Autowired
    private SelectDao selectDao;

    @Override/*HttpServletRequest req*/
    public AnimalInfo selectName(String name) throws UnsupportedEncodingException {
       //创建AnimalInfo对象
        AnimalInfo animalInfo=selectDao.selectAllInfo(name);
        //关联信息
        List<AnimalInfo> kinds= animalInfo.getKinds();
        if(kinds!=null&&kinds.size()>0){
            //保存关联的相似动物或者科目信息
            List<AnimalInfo> kindsQuery = getAnimalInfos(kinds);
            //关联信息，重新赋值
            animalInfo.setKinds(kindsQuery);

        }
        //相似信息
        List<AnimalInfo> similaryts= animalInfo.getSimilartys();
        if(similaryts!=null&&similaryts.size()>0){
            //保存查询的相似动物或者科目信息
            List<AnimalInfo> similarytsQuery = getAnimalInfos(similaryts);
            //相似信息，重新赋值
            animalInfo.setSimilartys(similarytsQuery);

        }


        //信息
        List<AnimalInfo> dongwus= animalInfo.getDongwus();
        if(dongwus!=null&&dongwus.size()>0){
            //保存查询的相似动物或者科目信息
            List<AnimalInfo> dongwusQuery = getAnimalInfos(dongwus);
            //相似信息，重新赋值
            animalInfo.setDongwus(dongwusQuery);

        }
        return animalInfo;


    }

    @Override
    public void update(AnimalInfo animalInfo) {
String name=animalInfo.getName();
String intro=animalInfo.getIntro();
try{
    AnimalInfo oldAnimalInfo=    selectName(name);
    String content= WriteToFileUtils.readTxtFile("E:\\llj\\Users\\Administrator\\IdeaProjects\\dongwuzhishiku\\src\\dongwuku.rdf");


    content= content.replace("<uni:intro>"+oldAnimalInfo.getIntro()+"</uni:intro>","<uni:intro>"+intro+"</uni:intro>");
    WriteToFileUtils.wirteToFile("E:\\llj\\Users\\Administrator\\IdeaProjects\\dongwuzhishiku\\src\\","aa.rdf",content);
}catch (Exception e){

}

    }

    /*下拉列表*/
    @Override
    public void spinnerName(String name,String queryClassLevel,HttpServletResponse resp) throws IOException {
            selectDao.spinner(name,queryClassLevel,resp);
    }

    //查询动物或者科目信息
    private List<AnimalInfo> getAnimalInfos(List<AnimalInfo> animalInfos) throws UnsupportedEncodingException {
        List<AnimalInfo> kindsQuery = new ArrayList<>();
        //如果有关联信息，那就查询
        for (int i = 0; i < animalInfos.size(); i++) {
            //animalInfos是list形式的有序列表,用get取值
            AnimalInfo s = animalInfos.get(i);
            String kname = s.getName();
            AnimalInfo  temp= selectDao.selectAllInfo(kname);
            if(temp.getName()!=null){
                kindsQuery.add(temp);
            }else{
                logger.error("kname="+kname+"未配置!");
            }

        }
        return kindsQuery;
    }

}
