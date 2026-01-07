import 'package:flutter/material.dart';
import '../widgets/court_card_list.dart';
import 'package:go_router/go_router.dart';
import '../../routing/app_router.dart';

class FavoriteCourtsPage extends StatelessWidget {
  const FavoriteCourtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorite Courts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CourtCardList(
            title: "Smash Arena",
            location: "DHA Phase 6",
            distance: "1.2 km",
            price: "PKR 3,000/hr",
            rating: "4.8",
            imageUrl:
                "https://lh3.googleusercontent.com/aida-public/AB6AXuAdqxXpj-kNDa6cFN2A44b0Iq5BFv8I28_34LdJ0OHE04XwpMU878f__2bYr6QpHy7csLwaPvPNMZQeiXeLxBhQoh5raKPutoeiHmh3s1vC13YkgbkJ6FgaSR-c8ncN_rO_hcIRD5vugkLaoDl6TkoG_OZ9eXYa74gOXweKsHe4yY7jc7I6CZ6uGZsBliVYhX-L4oSbjlLBpnVH8wEDBMqQcCc5Gmc4qzF5Aso8E1XyfLoCaFumNAxeTOEC_EEC31qnBybA4XCVdqU",
            onTap: () => context.push(AppRouter.details),
          ),
          const SizedBox(height: 16),
          CourtCardList(
            title: "Powerplay Nets",
            location: "Gulshan-e-Iqbal",
            distance: "4.5 km",
            price: "PKR 1,500/hr",
            rating: "4.5",
            imageUrl:
                "https://lh3.googleusercontent.com/aida-public/AB6AXuAVkiviyEEfa_D-odhbEJR1taRU0ZNR2cygmSQE5YuytOiGKAOs97pACkTnxkR6sbwiBSqMTqCJBZzEyfR7Sa7uVaiPQBDrAeF-VDjMuE4awZGpeU7KeP45Gsz_PsMzuSgwCmgq9kMPjCTEP3uOGBWuuxrYpiEMoneLVXc7xKrWUrRd_tyZirfCMWXiay1QUpiEjprsX4e4K0OKcS2C09ga4mSa-2s62NRrwxrOPshDy6yaMQxL9eacUg6iBmVTeSXIDthNrKx9E9c",
            onTap: () => context.push(AppRouter.details),
          ),
        ],
      ),
    );
  }
}
