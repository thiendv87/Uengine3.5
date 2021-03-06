package org.uengine.kernel;

import java.io.Serializable;
import java.util.Map;
import java.util.Properties;

import org.metaworks.FieldDescriptor;
import org.metaworks.inputter.InputterAdapter;
import org.metaworks.web.HTML;
import org.uengine.contexts.TextContext;
import org.uengine.processdesigner.inputters.*;

public class RolePointingProcessVariable extends ProcessVariable{
	private static final long serialVersionUID = org.uengine.kernel.GlobalContext.SERIALIZATION_UID;

	Role role;
		public Role getRole() {
			return role;
		}
		public void setRole(Role role) {
			this.role = role;
		}
		
	public void set(ProcessInstance instance, String scope, Serializable value) throws Exception {
		if(value instanceof RoleMapping){
			instance.putRoleMapping(getRole().getName(), (RoleMapping)value);
		}else if(value instanceof String){
			instance.putRoleMapping(getRole().getName(), (String)value);
		}
	}
	
	public TextContext getDisplayName() {
		TextContext result = new TextContext(){

			public String getText(String locale) {
				return "[Role]" + getRole().getDisplayName().getText(locale);
			}
			
		};
//		result.setText("[Role]" + getRole().getDisplayName());
		return result;
	}
	
	public String getName() {
		return getRole().getName();
	}

	public Class getType() {
		return Role.class;
	}

	public InputterAdapter getInputter() {
		org_uengine_kernel_RoleMappingInput rmi = new org_uengine_kernel_RoleMappingInput();
		rmi.setRole(getRole());
		
		return rmi;
	}
	
	
	
}
