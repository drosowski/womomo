package de.womomo

import org.apache.commons.lang.builder.HashCodeBuilder

class UserAccountRole implements Serializable {

	UserAccount userAccount
	Role role

	boolean equals(other) {
		if (!(other instanceof UserAccountRole)) {
			return false
		}

		other.userAccount?.id == userAccount?.id &&
			other.role?.id == role?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (userAccount) builder.append(userAccount.id)
		if (role) builder.append(role.id)
		builder.toHashCode()
	}

	static UserAccountRole get(long userAccountId, long roleId) {
		find 'from UserAccountRole where userAccount.id=:userAccountId and role.id=:roleId',
			[userAccountId: userAccountId, roleId: roleId]
	}

	static UserAccountRole create(UserAccount userAccount, Role role, boolean flush = false) {
		new UserAccountRole(userAccount: userAccount, role: role).save(flush: flush, insert: true)
	}

	static boolean remove(UserAccount userAccount, Role role, boolean flush = false) {
		UserAccountRole instance = UserAccountRole.findByUserAccountAndRole(userAccount, role)
		instance ? instance.delete(flush: flush) : false
	}

	static void removeAll(UserAccount userAccount) {
		executeUpdate 'DELETE FROM UserAccountRole WHERE userAccount=:userAccount', [userAccount: userAccount]
	}

	static void removeAll(Role role) {
		executeUpdate 'DELETE FROM UserAccountRole WHERE role=:role', [role: role]
	}

	static mapping = {
		id composite: ['role', 'userAccount']
		version false
	}
}
