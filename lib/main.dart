import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


// 🧓 Great-Grandparent
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fun Signup App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // 🔑 The Global Key - acts like a remote control for the form
  final _formKey = GlobalKey<FormState>();
  
  // 📝 Controllers to track what the user types
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //New method to confirm password
  final TextEditingController _confirmPasswordController = TextEditingController();

  //Avavtar selection
  String _selectedAvatar = '😊';

  //animation state fade effect added 
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold( // 👨 Parent
      appBar: AppBar(
        title: const Text('Join Us Today for the Cash Money!'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form( // 👶 Child
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Create Your Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              
              // 👤 Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // 📧 Email Field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // 🔒 Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //This method confirms the password entered by the user 
              TextFormField( 
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  //This compares the original password with the one enetered 
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ), 

              const SizedBox(height: 20),

              //Avvatar Picker UI
              const Text(
                'Choose Your Avatar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['😊', '🚀', '🔥', '🎮', '💻'].map((emoji) {
                  return GestureDetector(
                    onTap: () {
                      setState(() { 
                        _selectedAvatar = emoji;
                      });
                    },
                    child: Text(  
                      emoji,
                      style: TextStyle(  
                        fontSize: 32,
                        color: _selectedAvatar == emoji
                        ? Colors.purple
                        : Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              //Animated Button fade effect
              AnimatedOpacity(  
                duration: const Duration(milliseconds: 500),
                opacity: _opacity,
                child: ElevatedButton(  
                  onPressed: () async { 
                    if (_formKey.currentState!.validate()){
                      setState(() {
                        _opacity = 0.3;
                      });
                      await Future.delayed( 
                        const Duration(milliseconds: 500));

                        Navigator.push(  
                          context,
                          MaterialPageRoute(  
                            builder: (context) => WelcomePage (
                              name: _nameController.text,
                              avatar: _selectedAvatar,
                            ),
                          ),
                        );

                        setState(() {
                          _opacity = 1.0;
                        });
                    }
                  }, 
                  style: ElevatedButton.styleFrom( // ⭐ FIXED: added style back
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: const Text( // ⭐ FIXED: added child back
                    'Sign Up',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ), // ⭐ FIXED: missing comma here
            ],
          ),
        ),
      ),
    );
  }
}

// ⭐ ADDED: Welcome screen for navigation
class WelcomePage extends StatelessWidget {
  final String name;
  final String avatar;

  const WelcomePage({
    super.key,
    required this.name,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              avatar,
              style: const TextStyle(fontSize: 60),
            ),
            const SizedBox(height: 20),
            Text(
              'Welcome, $name!',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}