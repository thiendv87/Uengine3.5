<%!
	public interface BPM_ProcInst extends IDAO{
		public Number getInstId();
		public void setInstId(Number id);
		
		public Number getDefName();
		public void setDefName(Number val);

		public Date getStartedDate();
		public void setStartedDate(Date val);

		public String getStatus();
		public void setStatus(String val);

		public String getInfo();
		public void setInfo(String val);

		public String getName();
		public void setName(String val);

		public Number getIsDeleted();
		public void setIsDeleted(Number val);
	}
%>