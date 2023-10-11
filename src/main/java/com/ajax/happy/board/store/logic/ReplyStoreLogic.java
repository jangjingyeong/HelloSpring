package com.ajax.happy.board.store.logic;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ajax.happy.board.domain.Reply;
import com.ajax.happy.board.store.ReplyStore;

@Repository
public class ReplyStoreLogic implements ReplyStore{

	@Override
	public int insertReply(SqlSession sqlSession, Reply reply) {
		int result = sqlSession.insert("ReplyMapper.insertReply", reply);
		return result;
	}

	@Override
	public int updateReply(SqlSession sqlSession, Reply reply) {
		int result = sqlSession.update("ReplyMapper.updateReply", reply);
		return result;
	}

	@Override
	public int deleteReply(SqlSession sqlSession, Reply reply) {
		int result = sqlSession.update("ReplyMapper.deleteReply", reply);
		return result;
	}

	@Override
	public List<Reply> selectReplyList(SqlSession sqlSession, int refBoardNo) {
		List<Reply> rList = sqlSession.selectList("ReplyMapper.selectReplyList", refBoardNo);
		return rList;
	}

}











