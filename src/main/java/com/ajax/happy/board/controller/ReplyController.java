package com.ajax.happy.board.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ajax.happy.board.domain.Reply;
import com.ajax.happy.board.service.ReplyService;
import com.google.gson.Gson;

@Controller
@RequestMapping("/reply")
public class ReplyController {
	@Autowired
	private ReplyService rService;
	
	@ResponseBody
	@RequestMapping(value="/add.kh", method=RequestMethod.POST)
	public String insertReply(ModelAndView mv
			, @ModelAttribute Reply reply
			, HttpSession session) {
		String replyWriter = "hong";
		int result = 0;
		if(replyWriter != null && !replyWriter.equals("")) {
			reply.setReplyWriter(replyWriter);
			result = rService.insertReply(reply);
		}
		if(result > 0) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/update.kh", method=RequestMethod.POST)
	public String updateReply(
			@ModelAttribute Reply reply
			, HttpSession session) {
		String replyWriter = "hong";
		int result = 0;
		if(replyWriter != null && !replyWriter.equals("")) {
			reply.setReplyWriter(replyWriter);
			result = rService.updateReply(reply);
		}
		if(result > 0) {
			return "success";
		} else {
			return "fail";			
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/delete.kh", method=RequestMethod.GET)
	public String deleteReply(
			@ModelAttribute Reply reply
			, HttpSession session) {
		String memberId = "hong";
		String replyWriter = "hong";
		reply.setReplyWriter(replyWriter);
		int result = 0;
		if(replyWriter != null && replyWriter.equals(memberId)) {
			result = rService.deleteReply(reply);
		}
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/list.kh"
					, produces = "application/json; charset=utf-8"
					, method = RequestMethod.GET)
	public String showReplyList(Integer boardNo) {
		List<Reply> rList = rService.selectReplyList(boardNo);
		// List 데이터를 JSON 형태로 만드는 방법 
		// 1. JSONObject, JSONArray 
		// 2. Gson
		// 3. HashMap 
		Gson gson = new Gson();
		return gson.toJson(rList);
	}
	
			
}


































