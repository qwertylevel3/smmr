package com.kwh.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kwh.common.TreeNode;
import com.kwh.service.ResourceService;
import com.kwh.service.UserService;
import com.kwh.utils.JsonUtils;
import com.kwh.utils.StringUtils;

@Controller
public class LoginController {
    private static final Logger LOG = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    private ResourceService resourceService;

    @Autowired
    private UserService userService;

    @RequestMapping(value = { "/login", "/" }, method = RequestMethod.GET)
    public String login(String target, Model model) {
        model.addAttribute("target", target);
        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String loginPost(String userNo, String password, String target) {
        if (StringUtils.isBlank(userNo, password)) {
            return "login?target=" + target;
        }
        if (userService.authentication(userNo, password)) {
            if (StringUtils.isNotBlank(target) && !"/".equals(target)) {
                return "redirect:" + target;
            }
            return "redirect:index";
        }
        return "login?target=" + target;
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(String userNo) {
        userService.cancellation(userNo);
        return "login";
    }

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(Model model) {
        List<TreeNode> menu = resourceService.getMenu(userService.getCurrentUser(), false);
        model.addAttribute("menu", JsonUtils.parseJSON(menu));
        LOG.info("进入首页");
        return "index";
    }

    @RequestMapping(value = "/nopermission", produces = {
            "application/json; charset=UTF-8" }, method = RequestMethod.GET)
    @ResponseBody
    public String nopermission() {
        return "没有权限！";
    }
}
