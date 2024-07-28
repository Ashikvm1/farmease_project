import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          return productProvider.isLoggedIn ? HomePage() : LoginScreen();
        },
      ),
    );
  }
}
class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement your password reset logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Password reset link sent to ${_emailController.text}'),
                  ),
                );
                Navigator.pop(context);
              },
              child: Text('Send Password Reset Link'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String email = _emailController.text;
                String password = _passwordController.text;

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter both email and password'),
                    ),
                  );
                } else {
                  Provider.of<ProductProvider>(context, listen: false).login(
                    email,
                    password,
                  );
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text('Don\'t have an account? Sign up'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                );
              },
              child: Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }
}



class SignupScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false).signup(
                  _nameController.text,
                  _emailController.text,
                  _passwordController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ShopScreen(),
    BagScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Bag',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/bagss.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'New collection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/assets/images/girl.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Summer sale',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('lib/assets/images/hoodies.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              ' ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('lib/assets/images/hoodies.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Men\'s hoodies',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShopScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
    {'image': 'lib/assets/images/Leather-Bag-PNG.png', 'name': 'Leather Bag', 'price': '1120', 'description': 'High quality leather bag'},
    {'image': 'lib/assets/images/pr4.png', 'name': 'Caprese', 'price': '1080', 'description': 'Stylish Caprese bag'},
    {'image': 'lib/assets/images/pr3.png', 'name': 'Lino Peres', 'price': '999', 'description': 'Elegant Lino Peres bag'},
    {'image': 'lib/assets/images/pr2.png', 'name': 'Baggit', 'price': '899', 'description': 'Durable Baggit bag'},
    {'image': 'lib/assets/images/pr1.jpg', 'name': 'Zouk', 'price': '1999', 'description': 'Trendy Zouk bag'},
  ];

  final List<Map<String, String>> categories = [
    {'image': 'lib/assets/images/ladies wear.png', 'name': 'Ladies wear'},
    {'image': 'lib/assets/images/kids.png', 'name': 'Kids wear'},
    {'image': 'lib/assets/images/men wear.png', 'name': 'Men\'s wear'},
    {'image': 'lib/assets/images/shoe.png','name': 'Shoes'},
    {'image': 'lib/assets/images/pr3.png', 'name': 'Bags'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/Leather-Bag-PNG-HD-Image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fashion sale',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CheckScreen()),
                          );
                        },
                        child: Text('Check'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewAllScreen()),
                      );
                    },
                    child: Text('View all'),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            categories[index]['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          categories[index]['name']!,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewAllScreen()),
                      );
                    },
                    child: Text('View all'),
                  ),
                ],
              ),
            ),
            Container(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 160,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Image.asset(
                                products[index]['image']!,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: Icon(Icons.favorite_border, color: Colors.black),
                                  onPressed: () {
                                    Provider.of<ProductProvider>(context, listen: false).addToFavorites(products[index]);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${products[index]['name']} added to favorites\nPrice: \₹${products[index]['price']}\nDescription: ${products[index]['description']}',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          products[index]['name']!,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '\₹${products[index]['price']}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Provider.of<ProductProvider>(context, listen: false).addToCart(products[index]);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${products[index]['name']} added to cart'),
                              ),
                            );
                          },
                          child: Text('Buy Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<ProductProvider>(context).cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bag'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(cartItems[index]['image']!),
                  title: Text(cartItems[index]['name']!),
                  subtitle: Text('\₹${cartItems[index]['price']}'),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentScreen(cartItems: cartItems)),
                );
              },
              child: Text('Pay Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteItems = Provider.of<ProductProvider>(context).favoriteItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(favoriteItems[index]['image']!),
            title: Text(favoriteItems[index]['name']!),
            subtitle: Text('\₹${favoriteItems[index]['price']}'),
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProductProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(user.image),
                  ),
                  SizedBox(height: 10),
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'My Orders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: user.orders.length,
                itemBuilder: (context, index) {
                  final order = user.orders[index];
                  return ListTile(
                    leading: Image.asset(order['image']!),
                    title: Text(order['name']!),
                    subtitle: Text('\₹${order['price']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ViewAllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> products = [
      {'image': 'lib/assets/images/Leather-Bag-PNG.png', 'name': 'Leather Bag', 'price': '1120', 'description': 'High quality leather bag'},
      {'image': 'lib/assets/images/pr4.png', 'name': 'Caprese', 'price': '1080', 'description': 'Stylish Caprese bag'},
      {'image': 'lib/assets/images/pr3.png', 'name': 'Lino Peres', 'price': '999', 'description': 'Elegant Lino Peres bag'},
      {'image': 'lib/assets/images/pr2.png', 'name': 'Baggit', 'price': '899', 'description': 'Durable Baggit bag'},
      {'image': 'lib/assets/images/pr1.jpg', 'name': 'Zouk', 'price': '1999', 'description': 'Trendy Zouk bag'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GridTile(
            child: Image.asset(products[index]['image']!, fit: BoxFit.cover),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(products[index]['name']!),
              subtitle: Text('\₹${products[index]['price']}'),
            ),
          );
        },
      ),
    );
  }
}

class CheckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Screen'),
      ),
      body: Center(
        child: Text('OOPS!\nSomething Wrong...Please try again'),
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  final List<Map<String, String>> cartItems;

  PaymentScreen({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    double totalAmount = cartItems.fold(0, (sum, item) => sum + double.parse(item['price']!));

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Column(
        children: [
          Image.asset('lib/assets/images/icici-bank-vector-logo.png', width: 100, height: 100),
          Text('Bank: ICICI Bank'),
          Text('Account Number: ******7890'),
          Text('Total Amount to be Paid: \₹${totalAmount.toStringAsFixed(2)}'),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(cartItems[index]['image']!),
                  title: Text(cartItems[index]['name']!),
                  subtitle: Text('\₹${cartItems[index]['price']}'),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false).addOrder(cartItems);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text('Payment successfully done'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Pay Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                  foregroundColor: Colors.white
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// user_model.dart
class User {
  final String name;
  final String image;
  final List<Map<String, String>> orders;

  User({
    required this.name,
    required this.image,
    required this.orders,
  });
}

class ProductProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void login(String email, String password) {
    // Perform login logic here (e.g., call an API, validate credentials)
    _isLoggedIn = true;
    notifyListeners();
  }

  void signup(String name, String email, String password) {
    // Perform signup logic here (e.g., call an API, create a new user)
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
  List<Map<String, String>> _cartItems = [];
  List<Map<String, String>> _favoriteItems = [];
  User _user = User(
    name: 'Ashik vm',
    image: 'lib/assets/images/profile.png',
    orders: [],
  );

  List<Map<String, String>> get cartItems => _cartItems;

  List<Map<String, String>> get favoriteItems => _favoriteItems;

  User get user => _user;


  void addToCart(Map<String, String> product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void addToFavorites(Map<String, String> product) {
    _favoriteItems.add(product);
    notifyListeners();
  }

  void addOrder(List<Map<String, String>> orders) {
    _user.orders.addAll(orders);
    _cartItems.clear();
    notifyListeners();
  }

  void setUserDetails(String name, String image) {
    _user = User(name: name, image: image, orders: _user.orders);
    notifyListeners();
  }
}

