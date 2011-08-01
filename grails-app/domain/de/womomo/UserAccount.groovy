package de.womomo

class UserAccount {

	String username
	String email
	String password
	boolean enabled = true
	boolean accountExpired = false
	boolean accountLocked = false
	boolean passwordExpired = false

	static constraints = {
		username(blank: false, unique: true)
		email(email: true)
		password(blank: false)
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserAccountRole.findAllByUserAccount(this).collect { it.role } as Set
	}
}
