package com.ajax.happy.user.domain;

public class User {
	private String userId;
	private String userPw;
	private String userName;
	private String userEmail;
	private String userAddress;
	
	public User() {}

	public User(String userId, String userPw) {
		super();
		this.userId = userId;
		this.userPw = userPw;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserAddress() {
		return userAddress;
	}

	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}

	@Override
	public String toString() {
		return "사용자 [아이디=" + userId + ", 비밀번호=" + userPw + ", 이름=" + userName + ", 이메일=" + userEmail
				+ ", 주소=" + userAddress + "]";
	}
	
}
