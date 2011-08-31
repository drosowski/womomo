package de.womomo

class UserAccount {

  def springSecurityService

  String username
  String email
  String password
  String password2
  boolean enabled = true
  boolean accountExpired = false
  boolean accountLocked = false
  boolean passwordExpired = false

  static transients = ['password2', 'springSecurityService']

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

  def beforeInsert = {
    encodePassword()
  }

  def beforeUpdate = {
    encodePassword()
  }

  /**
   * Encode password using springSecurityService, only if both password and passwordVerification have been supplied.
   */
  void encodePassword() {
    // only encode password if it has been reset
    if (this.password && this.password2) {
      this.password = springSecurityService.encodePassword(this.password)

      // reset password verification so we don't accidentally re-encode password on udpate
      this.password2 = null
    }
  }

  Set<Role> getAuthorities() {
    UserAccountRole.findAllByUserAccount(this).collect { it.role } as Set
  }
}
