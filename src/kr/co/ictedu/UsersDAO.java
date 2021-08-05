package kr.co.ictedu;

import java.sql.*;

//DAO클래스는 DB연동을 전담해 처리합니다.
public class UsersDAO {
	
	//DB주소 아이디 패스워드 미리 저장
	private static final String url = "jdbc:mysql://localhost/ict03";
	private static final String DBID = "root";
	private static final String DBPW = "mysql";
	
	// 메서드 결과에 따른 리턴값 상수로 표기
	private static final int ID_WHATEVER_SUCCESS = 1;
	private static final int ID_WHATEVER_FAIL = 0;
	
	/*
	 * DAO클래스는 하나의 객체만으로도 DB연동을 수행할 수 있기 때문에
	 * 메모리 관리 차원에서 클래스의 객체를 단 1개만 생성하도록
	 * 싱글톤 패턴을 적용하여 클래스를 디자인합니다.
	 */
	
	// 싱글톤 패턴 클래스 디자인 방법
	// 1. 외부에서 객체를 new키워드로 만들어 쓸 수 없도록 생성자에
	// private을 붙여줍니다.
	private UsersDAO() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 2. 외부에서 객체생성을 못하기 때문에 자기 클래스 내부에서 그냥
	// 스스로 자기 자신을 1개 생성합니다.
	private static UsersDAO dao = new UsersDAO();
	
	// 3. 외부에서 객체 생성이 필요할 때 public선언으로 처리한
	// getter를 이용해 2에서 만든 객체를 리턴만 해줍니다.
	// 이렇게 하면 UsersDAO는 참조형 변수기 때문에 주소값만 전달합니다.
	public static UsersDAO getInstance() {
		return dao;
	}
	
	// START joinUsers
	// 회원가입을 처리하는 메서드 선언
	// DB에 들어가는 데이터, 혹은 DB에서 출력되어 나오는 데이터
	// 모두가 UsersVO내부 자료 형식을 벗어날 수 없으므로
	// 대다수 입출력은 전부 VO를 매개로 진행합니다.
	public int joinUsers(UsersVO user) {
		//users_join.jsp에서 가져온 코드를 이곳에 붙여넣기 합니다.
		// 연결로직
		Connection con = null;
		// 쿼리문 실행을 위한 PreparedStatement 객체 생성
		PreparedStatement pstmt = null;
		
		try{
		
			//접속 주소, 계정, 비밀번호를 이용해 접속요청을 넣습니다.
			con = DriverManager.getConnection(url, DBID, DBPW);
			
			//1.쿼리문을 작성합니다.
			String sql = "INSERT INTO users VALUES(?, ?, ?, ?)";
			
			//2.만든 쿼리문의 ?자리에 적용할 자바 변수를 집어넣습니다.
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getUpw());
			pstmt.setString(3, user.getUname());
			pstmt.setString(4, user.getEmail());
			
			//4.만든 쿼리문 실행하기
			pstmt.executeUpdate();
			
			
			
		}catch(SQLException e){
			System.out.println("에러 : " + e);
		}finally{
			try{
				if(con!=null && !con.isClosed()){
					con.close();
				}if(pstmt!=null && !pstmt.isClosed()){
					pstmt.close();
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		return ID_WHATEVER_SUCCESS;
	}// END joinUser
	
	
	// START usersDelete
	// 원래 대다수 DAO는 UsersVO 하나로 모든 처리를 해결할 수 있습니다.
	// 다만 삭제 로직은 폼에서 날린 비밀번호와 원래 DB에 저장되어있던 비밀번호를
	// 비교해야 하기 때문에 탈퇴시 입력받은 비밀번호를 추가로 받습니다.(delPw)
	public int usersDelete(UsersVO user, String delPw) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
			//DB연결 로직	
			try{
				//UsersVO에 입력된 비밀번호와 폼에서 날린 delPw를 비교
			if(user.getUpw().equals(delPw)){
				con = DriverManager.getConnection(url, DBID, DBPW);
				
				//1. DELETE 쿼리문 작성
				String sql = "DELETE FROM users WHERE id=?";
				
				//2. 쿼리문의 물음표 자리에 적용할 변수를 넣는다.
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, user.getId());
				
				//3. 쿼리문 실행
				pstmt.executeUpdate();
			//내부적으로 session, response등 내장 객체에 대한 처리를 할 수 없으므로,
			//결과정보만 리턴
				return ID_WHATEVER_SUCCESS;
			}else {
				//비밀번호를 다르게 입력한 경우
				return ID_WHATEVER_FAIL;
			}
				
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			//연결 끊기
			try{
				if(con!=null && !con.isClosed()){
					con.close();
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		//상단 try블럭 내에서 로직이 처리가 안되어, 여기까지 코드가 도달했다는 자체로 
		//이미 뭔가 실행이 누락되었다는 의미 이므로 0을 리턴한다.
		return ID_WHATEVER_FAIL;
		
	}// END usersDelete
	
	
	
	// START userLogin
	public int userLogin(UsersVO user, String uid, String upw) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
			//DB연결 로직	
			try{
				con = DriverManager.getConnection(url, DBID, DBPW);
				
				//1. SELECT 쿼리문 작성
				String sql = "SELECT * From users WHERE id=?";
				
				//2. 쿼리문의 물음표 자리에 적용할 변수를 넣는다.
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, user.getId());
				
				//3. 쿼리문 실행
				rs = pstmt.executeQuery();
				
				//UsersVO에 입력된 아이디&비밀번호 와 로그인시 입력한 id & pw 비교 후 결과 도출 
				if(rs.next()){
					String dbid = rs.getString("id");
					String dbpw = rs.getString("upw");
					if(user.getId().equals(dbid) && user.getUpw().equals(dbpw)) {
			//내부적으로 session, response등 내장 객체에 대한 처리를 할 수 없으므로,
			//결과정보만 리턴
						return ID_WHATEVER_SUCCESS;
					}else {
				//비밀번호를 다르게 입력한 경우
						return ID_WHATEVER_FAIL;
					}
				}
				
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			//연결 끊기
			try{
				if(con!=null && !con.isClosed()){
					con.close();
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		//상단 try블럭 내에서 로직이 처리가 안되어, 여기까지 코드가 도달했다는 자체로 
		//이미 뭔가 실행이 누락되었다는 의미 이므로 0을 리턴한다.
		return ID_WHATEVER_FAIL;
			
	}//END userLogin
	
	
	// getUserInfo 매서드
	// 수정 로직을 사용하기 전에 수정할 타겟 아이디의 정보를 얻어오기 위해
	// 사용하는 메서드로 아이디, 비밀번호, 이름, 이메일을 
	// UsersVO에 넣어서 리턴합니다. 
	public UsersVO getUserInfo(UsersVO user) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 비어있는 UsersVO도 같이 선언
		UsersVO resultData = new UsersVO();
		
		// DB연결 후 입력받은 user의 .getUid()를 이용해 조회구문 완성
		try{
			con = DriverManager.getConnection(url, DBID, DBPW);
			
			String sql = "SELECT * From users WHERE id=?";
						
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user.getId());
			
			rs = pstmt.executeQuery();
			
		// 이후 ResultSet에 담겨있는 자료를 다시 다 꺼내서
		// 새로 선언한 UsersVO 변수에 입력해준 후
			if(rs.next()) {
				resultData.setId(rs.getString("id"));
				resultData.setUpw(rs.getString("upw"));
				resultData.setUname(rs.getString("uname"));
				resultData.setEmail(rs.getString("email"));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			//연결 끊기
			try{
				if(con!=null && !con.isClosed()){
					con.close();
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}//ResultSet을 있던 자료를 입력받은 UsersVO를 리턴
		return resultData;
	}// END UsersVO getUserInfo()

	
	
	// START userUpdate
	public int userUpdate(UsersVO user) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		UsersVO resultData = new UsersVO();
		
		try{
			
			//Connection 객체를 생성
			con = DriverManager.getConnection(url, DBID, DBPW);
			
			String sql = "UPDATE users SET upw=?, uname=?, email=? WHERE id=?";

			//PreparedStatement 객체 생성, 객체 생성시 SQL문장 저장			
			pstmt = con.prepareStatement(sql);
			
			
			pstmt.setString(1, resultData.getUpw());
			pstmt.setString(2, resultData.getUname());
			pstmt.setString(3, resultData.getEmail());
			pstmt.setString(4, user.getId());
			
			pstmt.executeUpdate();
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			//연결 끊기
			try{
				if(pstmt!=null && !pstmt.isClosed()){
					pstmt.close();
				}
				if(con!=null && !con.isClosed()){
					con.close();
				}
				
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		return 0;
		
	}
	
	
}// UsersDAO

	
	
	
