package de.womomo

class UserAccount {

  String username
  String email
  String password
  String password2
  boolean enabled = true
  boolean accountExpired = false
  boolean accountLocked = false
  boolean passwordExpired = false

  static transients = ['password2']

  static constraints = {
    username(blank: false, unique: true)
    email(email: true, unique: true)
    password(blank: false, validator: { value, obj ->
      // skip matching password validation (only important when setting/resetting password)
      if (obj.password2 == null) return true
      if (obj.password2 == value) {
        return true
      }
      else {
        return ['userAccount.error.password_mismatch']
      }
    })
    password2(nullable: true)
  }

  static mapping = {
    password column: '`password`'
  }

  Set<Role> getAuthorities() {
    UserAccountRole.findAllByUserAccount(this).collect { it.role } as Set
  }
}
