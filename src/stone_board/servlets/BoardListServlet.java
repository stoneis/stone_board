package stone_board.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import stone_board.db.DBConnection;

@WebServlet("/BoardListServlet")
public class BoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	Connection conn = DBConnection.getConnection();
	Statement stmt = null;
	ResultSet rs = null;
	
	public BoardListServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		try {
			stmt = conn.createStatement();
			stmt.execute("SELECT COUNT(*) AS TOTAL FROM BOARD");
			rs = stmt.getResultSet();

			while (rs.next()) {
				request.setAttribute("total", rs.getString("TOTAL"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		RequestDispatcher requestDispatcher = 
				request.getRequestDispatcher("/WEB-INF/jsp/boardList.jsp");
		requestDispatcher.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
}
