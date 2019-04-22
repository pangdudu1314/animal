package com.dao;

import com.hp.hpl.jena.query.QuerySolution;
import com.hp.hpl.jena.query.ResultSet;
import com.hp.hpl.jena.rdf.model.Literal;
import com.pojo.AnimalInfo;
import com.utils.JsonUtils;
import com.utils.RegExUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component("selectDao")
public class SelectDao {
  /* public static void main(String []aa){
        SelectDao dao=new SelectDao();
        System.out.println(dao.selectAllInfo("猫科" ));
    }*/

/*    JSONArray nodes = new JSONArray();
    JSONArray links = new JSONArray();*/

    //查询所有信息
    public AnimalInfo selectAllInfo(String name) throws UnsupportedEncodingException {
        String allQuery = "SELECT ?x ?re WHERE {?sub uni:name \"" + name + "\". ?sub ?re ?x}";//查询所有标签
       //ResultSet类是一种数据库查询结果存储类，就是当查询数据库的时候，可以将查询的结果放在具体的ResultSet对象中，其实我们把这种存储查询结果的ResultSet对象叫做ResultSet结果集。
        ResultSet allResult =RdfDaoUtils.createRdfDaoUtils().queryResult(allQuery);//rdfDaoUtils.queryResult(allQuery)
        //创建一个AnimalInfo的对象
        AnimalInfo animalInfo=new AnimalInfo();
        //这里如果查询的是猫科，name返回的是猫科和kind等信息集合
        while (allResult.hasNext()) {

            QuerySolution next = allResult.next();
            Literal literal = next.getLiteral("x");
            String type = next.getResource("re").getLocalName();//类别 name kind1， kind2， kind3 等
            String value = literal.getValue().toString();//动物类别名称或者动物名称
            System.out.println("type="+type+",value="+value);//打印确认看一下

            if (type.equals("name")) {
                animalInfo.setName(value);
            }
            else if (type.startsWith("image")) {//以kind开头的类别
                animalInfo.setImage(value.replaceFirst("image://",""));

            }else if (type.startsWith("kind")) {
                AnimalInfo kind=new AnimalInfo();
                //value是对应<uni:name>value</uni：name>
                kind.setName(value);
                animalInfo.addKind(kind);
            }else if (type.startsWith("intro")) {
                animalInfo.setIntro(value);

            }else if (type.startsWith("xiang")) {
                animalInfo.setXiang(value);
            }else if (type.startsWith("guan")) {
                animalInfo.setGuan(value);
            }else if (type.startsWith("similarty")) {

                AnimalInfo similarty=new AnimalInfo();
                similarty.setName(value);
                animalInfo.addSimilarty(similarty);
            }else if (type.startsWith("dongwu")) {

                AnimalInfo dongwu=new AnimalInfo();
                dongwu.setName(value);
                animalInfo.addDongwus(dongwu);
            }

        }
        return animalInfo;
    }



    public void spinner(String name, String queryClassLevel, HttpServletResponse resp) throws IOException {
        List list=new ArrayList();
        if(name==null){
            name="";
        }
     //   name = new String(name.getBytes("ISO-8859-1"), "UTF-8");
        String contents= RdfDaoUtils.createRdfDaoUtils().laodRdfFile1();
        //按照关键字开始 结束标记 进行提取数据，返回多组数据
        //以数组方式返回参数2和参数3中间的字符串(StringUtils 截取字符串 substring)
        String[] eachPart= StringUtils.substringsBetween(contents,"rdf:Description","/rdf:Description");
        if("1".equals(queryClassLevel)){
            //读取全部文件内容
            for(String ep:eachPart){
                if(ep.contains("uni:kind")){
                    //数据中包含kind的认为是科类
                    String type= StringUtils.substringBetween(ep,"uni:name>","</uni:name");
                    Map map=new HashMap();
                    map.put("id",type);
                    map.put("text",type);
                    list.add(map) ;
                }
            }
        }else{
            //选中科目以后的动物名称
            for(String ep:eachPart){
                if(ep.contains("uni:kind") && ep.contains(name)){
                    //数据中包含kind的认为是科类
                    List<String>  allName=  RegExUtils.getMatchResult(ep,"kind\\d>(.+)</uni:kind");
                    Map mapNUll=new HashMap();
                    mapNUll.put("id","");
                    mapNUll.put("text","");
                    list.add(mapNUll) ;
                    for(String aname:allName){
                        Map map=new HashMap();
                        map.put("id",aname);
                        map.put("text",aname);
                        list.add(map) ;
                    }
                }
            }

        }

        String json= JsonUtils.getString(list);
        System.out.println(json);
        resp.setContentType("text/javascript;charset=utf-8");
        resp.getWriter().write(json);

    }

}
