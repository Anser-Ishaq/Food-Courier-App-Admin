import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_couriers_admin/components/gradient_text.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/constants/images/images.dart';
import 'package:food_couriers_admin/constants/routes/routes.dart';
import 'package:food_couriers_admin/utils.dart';
import 'package:go_router/go_router.dart';

class MobileLogin extends StatefulWidget {
  const MobileLogin({super.key});

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = true;
  bool? _rememberMe = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(
                left: 170.w,
                right: 170.w,
                top: 40.h,
              ),
              color: AppColors.white.withOpacity(0.4),
              child: _formUI(),
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                gradient: AppColors.gradientPrimary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(200.r),
                  topRight: Radius.circular(200.r),
                ),
              ),
              child: _footer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formUI() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _backButton(onTap: () {}),
          SizedBox(height: 150.h),
          _signinText(),
          SizedBox(height: 12.h),
          _explaingText(),
          SizedBox(height: 60.h),
          // _googleSigninButton(onTap: () {}),
          // SizedBox(height: 35.h),
          // _orTextRow(),
          // SizedBox(height: 40.h),
          _labelText('Email'),
          SizedBox(height: 20.h),
          _inputContainer(
            hintText: 'mail@simmmple.com',
            controller: _emailController,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 30.h),
          _labelText('Password'),
          SizedBox(height: 20.h),
          _inputContainer(
            hintText: 'Min. 8 characters',
            controller: _passwordController,
            obscureText: _isPasswordVisible,
            keyboardType: TextInputType.visiblePassword,
            isIcon: true,
            onTap: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          SizedBox(height: 40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rememberMeRow(
                value: _rememberMe,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value;
                  });
                },
              ),
              _forgotPasswordText(onTap: () {}),
            ],
          ),
          SizedBox(height: 60.h),
          _signinButton(
            onTap: () {
              context.goNamed(Routes.home);
            },
          ),
          SizedBox(height: 70.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _loginAsButton(
                text: 'Login as Admin',
                gradient: AppColors.gradientPrimary,
                border: Border.all(
                  color: AppColors.primary,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
                onTap: () {},
              ),
              _loginAsButton(
                text: 'Login as Owner',
                gradient: AppColors.gradientTextDarkColor,
                border: Border.all(
                  color: AppColors.textDarkColor,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 190.h),
        ],
      ),
    );
  }

  Widget _loginAsButton({
    required String text,
    required LinearGradient gradient,
    required VoidCallback onTap,
    required BoxBorder border,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: border,
        ),
        child: GradientText(
          text: text,
          style: const TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.02 * 14,
          ),
          gradient: gradient,
        ),
      ),
    );
  }

  Widget _signinButton({
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 54.h,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: AppColors.gradientPrimary,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          'Sign In',
          style: TextStyle(
            color: AppColors.white,
            fontFamily: 'DM Sans',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 14.h / 14,
            letterSpacing: -0.02 * 14,
          ),
        ),
      ),
    );
  }

  Widget _forgotPasswordText({
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        'Forget Password?',
        style: TextStyle(
          color: AppColors.primary,
          fontFamily: 'DM Sans',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 20.h / 14,
          letterSpacing: -0.02 * 14,
        ),
      ),
    );
  }

  Widget _rememberMeRow({
    required bool? value,
    required void Function(bool?)? onChanged,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          splashRadius: 0.1,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text(
          'Keep me logged in',
          style: TextStyle(
            color: AppColors.textDarkColor,
            fontFamily: 'DM Sans',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 20.h / 14,
            letterSpacing: -0.02 * 14,
          ),
        ),
      ],
    );
  }

  Widget _inputContainer({
    required String hintText,
    required TextEditingController controller,
    required bool obscureText,
    required TextInputType keyboardType,
    bool? isIcon,
    VoidCallback? onTap,
  }) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(
        color: AppColors.borderColor,
        width: 1.w,
      ),
    );
    return SizedBox(
      height: 50.h,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: AppColors.textDarkColor,
          fontFamily: 'DM Sans',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.02 * 14,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.silver,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 25.w),
          suffixIcon: isIcon != null
              ? GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    obscureText
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    size: 18,
                    color: AppColors.silver,
                  ),
                )
              : null,
          border: border,
          focusedBorder: border,
          enabledBorder: border,
        ),
      ),
    );
  }

  Widget _labelText(String label) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 14.h / 14,
          letterSpacing: -0.02 * 14,
        ),
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(
              color: AppColors.textDarkColor,
            ),
          ),
          const TextSpan(
            text: '*',
            style: TextStyle(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _orTextRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _divider(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            'or',
            style: TextStyle(
              color: AppColors.silver,
              fontFamily: 'DM Sans',
              fontSize: screenWidth! / 35,
              fontWeight: FontWeight.w500,
              height: 24.h / 14,
              letterSpacing: -0.02 * 14,
            ),
          ),
        ),
        _divider(),
      ],
    );
  }

  Widget _divider() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.r),
          border: Border.all(
            color: AppColors.borderColor,
            width: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _googleSigninButton({
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 54.h,
        padding: EdgeInsets.symmetric(vertical: 15.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: AppColors.gradientSecondary,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              Images.google,
              width: 27.w,
              height: 27.h,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 11.w),
            Text(
              'Sign in with Google',
              style: TextStyle(
                color: AppColors.textDarkColor,
                fontFamily: 'DM Sans',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 20.h / 14,
                letterSpacing: -0.02 * 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _explaingText() {
    return Padding(
      padding: EdgeInsets.only(left: 1.w),
      child: Text(
        'Enter your email and password to sign in!',
        maxLines: 1,
        style: TextStyle(
          color: AppColors.silver,
          fontFamily: 'DM Sans',
          fontSize: screenWidth! / 35,
          fontWeight: FontWeight.w400,
          height: 16.h / 16,
          letterSpacing: -0.02 * 16,
        ),
      ),
    );
  }

  Widget _signinText() {
    return Text(
      'Sign In',
      style: TextStyle(
        color: AppColors.textDarkColor,
        fontFamily: 'DM Sans',
        fontSize: screenWidth! / 15,
        fontWeight: FontWeight.w700,
        height: 56.h / 36,
        letterSpacing: -0.02 * 36,
      ),
    );
  }

  Widget _backButton({
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.arrow_back_ios_new_rounded,
            size: screenWidth! * 0.018,
            color: AppColors.silver,
          ),
          SizedBox(width: 6.w),
          Text(
            'Back',
            style: TextStyle(
              color: AppColors.silver,
              fontFamily: 'DM Sans',
              fontSize: screenWidth! * 0.02,
              fontWeight: FontWeight.w500,
              height: 30.h / 14,
              letterSpacing: -0.02 * 14,
            ),
          ),
          SizedBox(width: 5.w),
        ],
      ),
    );
  }

  Widget _footer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          Images.icon,
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.width * 0.3,
          fit: BoxFit.contain,
        ),
        const Text(
          'Food Couriers',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.white,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w400,
            fontSize: 30,
          ),
        ),
        SizedBox(
          height: 0.02 * screenWidth!,
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26.37.r),
            border: Border.all(
              color: AppColors.white.withOpacity(0.2),
              width: 2.2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Learn more about Food Couriers on',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  color: AppColors.white,
                  fontFamily: 'DM Sans',
                  fontSize: 0.04 * screenWidth!,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 6.91,
              ),
              Text(
                'foodcouriers.com',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  color: AppColors.white,
                  fontFamily: 'DM Sans',
                  fontSize: 0.06 * screenWidth!,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 0.05 * screenWidth!,
        ),
      ],
    );
  }
}
