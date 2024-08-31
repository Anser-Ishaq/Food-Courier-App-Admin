import 'package:food_couriers_admin/constants/images/images.dart';
import 'package:food_couriers_admin/models/restaurant.dart';

final List<Restaurant> restaurants = [
  Restaurant(
    rid: '1',
    name: 'The Gourmet Kitchen',
    address: 'New York, NY',
    logo: Images.burger,
    ownerName: 'John Doe',
    ownerEmail: 'johndoe@example.com',
    ownerPhone: '123-456-7890',
    creationDate: DateTime(2022, 5, 16, 9, 17),
    active: true,
  ),
  Restaurant(
    rid: '2',
    name: 'Sushi World',
    address: 'Los Angeles, CA',
    logo: Images.burger,
    ownerName: 'Jane Smith',
    ownerEmail: 'janesmith@example.com',
    ownerPhone: '098-765-4321',
    creationDate: DateTime(2021, 12, 9, 13, 30),
    active: false,
  ),
  Restaurant(
    rid: '3',
    name: 'Pasta Palace',
    address: 'Chicago, IL',
    logo: Images.burger,
    ownerName: 'Mario Rossi',
    ownerEmail: 'mariorossi@example.com',
    ownerPhone: '456-789-1230',
    creationDate: DateTime(2023, 1, 20, 18, 43),
    active: true,
  ),
];
