package com.controller;

import com.pojo.AnimalInfo;
import com.service.SelectService;
import com.utils.JsonUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

@Controller
@RequestMapping("/queryClass")
public class SelectController {



    @Autowired
    public SelectService selectService;

    @RequestMapping("/queryClassLevel")/**/
    public void spinnerName(String name, String level,HttpServletResponse response ) throws IOException {
        selectService.spinnerName(name,level,response);
    }

    @RequestMapping("/selectAdmin")/*HttpServletRequest req*/
    public  String selectAdmin(String name, HttpServletRequest request,HttpServletResponse response ) throws UnsupportedEncodingException {
        JSONArray nodes = new JSONArray();
        JSONArray links = new JSONArray();
        //查询http://localhost:8888/dongwuzhishiku_war_exploded/queryClass/queryClassLevel
        /*name="松鸡";//测试，先写死*/
      //  name = new String(name.getBytes("ISO-8859-1"), "UTF-8");
        System.out.println("name===============" + name);
        request.setAttribute("key",name);
        AnimalInfo animalInfo = selectService.selectName(name);
   /*     System.out.println("animalInfo========================" + animalInfo);*/

        if (animalInfo.getKinds() != null) {
            //name对应的动物或者科目节点信息
            JSONObject animalNode = new JSONObject();
            animalNode.put("category", 0);
            animalNode.put("name", animalInfo.getName());
            animalNode.put("value", 80);
            animalNode.put("symbol", animalInfo.getImage());
            animalNode.put("symbolSize", "[80, 80]");
            nodes.add(animalNode);
            //关系
            List<AnimalInfo> kinds = animalInfo.getKinds();
            if (kinds != null && kinds.size() > 0) {
                for (int i = 0; i < kinds.size(); i++) {
                    AnimalInfo k = kinds.get(i);
                    //这里填充 nodes和links等信息
                    JSONObject node = new JSONObject();
                    node.put("category", 0);
                    node.put("name", k.getName());
                    node.put("value", 80);
                    node.put("symbol", k.getImage());
                    node.put("symbolSize", "[40, 40]");

                    nodes.add(node);

                    //链路关联信息
                    JSONObject LinkNode = new JSONObject();
                    LinkNode.put("source", animalInfo.getName());
                    LinkNode.put("target", k.getName());
                    LinkNode.put("weight", 0.0000000000000000000000000001);
                    links.add(LinkNode);
                }
            }



        } else {
                //name对应的动物或者科目节点信息
                JSONObject animalNode = new JSONObject();
                animalNode.put("category", 0);
                animalNode.put("name", animalInfo.getName());
                animalNode.put("value", 80);
                animalNode.put("symbol", animalInfo.getImage());
                animalNode.put("symbolSize", "[150, 150]");
                nodes.add(animalNode);
            }

        request.setAttribute("nodes", nodes);
        request.setAttribute("links", links);
        request.setAttribute("animalInfo", animalInfo);
        System.out.println("animalInfo="+ JsonUtils.getString(animalInfo));
            return "dongwu";
        }


    @RequestMapping("/gotoFrame")
    public String gotoFrame() throws IOException {
        return "frame";
    }

    @RequestMapping("/frame_a")
    public String frame_a() throws IOException {
        return "frame_a";
    }

    @RequestMapping("/frame_b")
    public String frame_b() throws IOException {
        return "frame_b";
    }

    @RequestMapping("/wenzi")
    public String wenzi() throws IOException {
        return "wenzichaxun";
    }

    @RequestMapping("/tupian")
    public String  tupian() throws IOException {
        return "tupianchaxun";
    }
    @RequestMapping("/bianji")
    public String  bianji(String name,HttpServletRequest request,HttpServletResponse response ) throws IOException {

        System.out.println("name===============" + name);

        AnimalInfo animalInfo = selectService.selectName(name);
        request.setAttribute("animalInfo", animalInfo);
        return "bianji";
    }

    @RequestMapping(value = "/updateAnimalInfo",method = RequestMethod.POST)
    public void  updateAnimalInfo(String name,String intro,HttpServletRequest request,HttpServletResponse response ) throws IOException {

        System.out.println("name===============" + name);
        System.out.println("intro===============" + intro);
        AnimalInfo animalInfo=new AnimalInfo();
        animalInfo.setName(name);
        animalInfo.setIntro(intro);
        selectService.update(animalInfo);
    }
}
