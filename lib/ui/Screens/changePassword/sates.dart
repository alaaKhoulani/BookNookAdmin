abstract class ChangePasswordStates {}

class ChangePasswordInitial extends ChangePasswordStates {}
class ChangePasswordSuccess extends ChangePasswordStates {}

class ChangePasswordShow extends ChangePasswordStates {}

class Password extends ChangePasswordStates {}

class NewPassword extends ChangePasswordStates {}

class Confirm extends ChangePasswordStates {}