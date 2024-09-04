import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_couriers_admin/components/gradient_text.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/constants/images/images.dart';
import 'package:food_couriers_admin/constants/routes/routes.dart';
import 'package:food_couriers_admin/provider/auth_provider.dart';
import 'package:food_couriers_admin/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TabletLogin extends StatefulWidget {
  const TabletLogin({super.key});

  @override
  State<TabletLogin> createState() => _TabletLoginState();
}

class _TabletLoginState extends State<TabletLogin> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 150.w, vertical: 40.h),
              child: _formUI(context),
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.7,
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

  Widget _formUI(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

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
          _labelText('Email'),
          SizedBox(height: 20.h),
          _inputContainer(
            hintText: 'mail@simmmple.com',
            controller: authProvider.emailController,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 30.h),
          _labelText('Password'),
          SizedBox(height: 20.h),
          _inputContainer(
            hintText: 'Min. 8 characters',
            controller: authProvider.passwordController,
            obscureText: authProvider.isPasswordVisible,
            keyboardType: TextInputType.visiblePassword,
            isIcon: true,
            onTap: authProvider.togglePasswordVisibility,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters long';
              }
              return null;
            },
          ),
          SizedBox(height: 40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rememberMeRow(
                value: authProvider.rememberMe,
                onChanged: authProvider.setRememberMe,
              ),
              _forgotPasswordText(onTap: () {}),
            ],
          ),
          SizedBox(height: 60.h),
          Column(
            children: [
              if (authProvider.errorMessage != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Text(
                    authProvider.errorMessage!,
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'DM Sans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              _signinButton(
                onTap: authProvider.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          final success = await authProvider.login(
                            authProvider.emailController.text.trim(),
                            authProvider.passwordController.text.trim(),
                          );
                          if (success) {
                            context.goNamed(Routes.home);
                          }
                        }
                      },
              ),
            ],
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
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: AppColors.gradientPrimary,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return authProvider.isLoading
                ? SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.w,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(AppColors.white),
                    ),
                  )
                : Text(
                    'Sign In',
                    style: TextStyle(
                      color: AppColors.white,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 14.h / 14,
                      letterSpacing: -0.02 * 14,
                    ),
                  );
          },
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
    String? Function(String?)? validator,
  }) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(
        color: AppColors.borderColor,
        width: 1.w,
      ),
    );
    return SizedBox(
      height: screenHeight! * 0.05,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
          color: AppColors.textDarkColor,
          fontFamily: 'DM Sans',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 14.h / 14,
          letterSpacing: -0.02 * 14,
        ),
        validator: validator,
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
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.silver,
                  ),
                )
              : null,
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: BorderSide(
              color: AppColors.primary,
              width: 1.5.w,
            ),
          ),
        ),
      ),
    );
  }

  Widget _labelText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.textDarkColor,
        fontFamily: 'DM Sans',
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 16.h / 14,
        letterSpacing: -0.02 * 14,
      ),
    );
  }

  Widget _explaingText() {
    return Text(
      'Enter your email and password to sign in!',
      style: TextStyle(
        color: AppColors.silver,
        fontFamily: 'DM Sans',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20.h / 14,
        letterSpacing: -0.02 * 14,
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
