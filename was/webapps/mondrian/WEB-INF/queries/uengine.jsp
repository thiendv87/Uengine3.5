<%@ page session="true" contentType="text/html; charset=ISO-8859-1" %>
<%@ taglib uri="http://www.tonbeller.com/jpivot" prefix="jp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib uri="http://www.uengine.org/favorite" prefix="fa" %>

<%-- uses a dataSource --%>
<%-- jp:mondrianQuery id="query01" dataSource="jdbc/MondrianFoodmart" catalogUri="/WEB-INF/demo/FoodMart.xml" --%>

<%-- uses mysql --%>
<%-- jp:mondrianQuery id="query01" jdbcDriver="com.mysql.jdbc.Driver" jdbcUrl="jdbc:mysql://localhost/foodmart" catalogUri="/WEB-INF/queries/FoodMart.xml"--%>

<%-- uses a role defined in FoodMart.xml --%>
<%-- jp:mondrianQuery role="California manager" id="query01" jdbcDriver="sun.jdbc.odbc.JdbcOdbcDriver" jdbcUrl="jdbc:odbc:MondrianFoodMart" catalogUri="/WEB-INF/queries/FoodMart.xml" --%>

<jp:mondrianQuery id="query01" jdbcDriver="org.hsqldb.jdbcDriver" jdbcUrl="jdbc:hsqldb:hsql://localhost/" jdbcUser="sa" jdbcPassword="" catalogUri="/WEB-INF/queries/uengine.xml">
select {[Measures].[Processing Time (Sum)], [Measures].[Processing Time (Avg)], [Measures].[Cost]} ON columns,
  Hierarchize({([Process Definition].[All Process Definitions], [ResourceByBirthday].[All Resources],[ResourceByGender].[All Resources],[ResourceByDepartment].[All Resources])}) ON rows
from [Performance]

</jp:mondrianQuery>


<fa:chart id="chart02" query="query01" visible="true"/>

<c:set var="title01" scope="session"></c:set>
