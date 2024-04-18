import 'package:flutter/material.dart';
import 'package:vc_product_network/vc_product_network.dart';

class DummyData {
  static currency1() {
    return Currency(
      iD: 1,
      code: 'USD',
      fullName: 'United States Dollar',
      name: 'Dollar',
      symbol: '\$',
      decimalDigits: 2,
      decimalDigitsSpecified: true,
      type: 'Fiat',
      isDeleted: false,
      categoryCode: CurrencyCategoryEnum.Other,
      guid: 'abc123',
      createdDate: DateTime.now(),
      createdBy: 'Admin',
      modifiedOn: DateTime.now(),
      modifiedBy: 'Admin',
    );
  }

  static currency2(){
    return Currency(
      iD: 2,
      code: 'EUR',
      fullName: 'Euro',
      name: 'Euro',
      symbol: '€',
      decimalDigits: 2,
      decimalDigitsSpecified: true,
      type: 'Fiat',
      isDeleted: false,
      categoryCode: CurrencyCategoryEnum.Other,
      guid: 'def456',
      createdDate: DateTime.now(),
      createdBy: 'Admin',
      modifiedOn: DateTime.now(),
      modifiedBy: 'Admin',
    );
  }

  static List<Map> menuItems() {
    return [
      {"title": "Accounts", "icon": Icons.account_balance_wallet_outlined, "description": ""},
      {"title": "Cards", "icon": Icons.credit_card, "description": ""},
      {
        "title": "Loans",
        "icon": Icons.currency_pound_rounded,
        "description": "",
        "type": 1,
        "level": 1,
        "children": [
          {"title": "My Loans", "description": "Review your loans", "icon": Icons.receipt_long_rounded},
          {"title": "Personal Loans", "description": "Apply for personal loans", "icon": Icons.wallet},
          {"title": "Auto Loans", "description": "Apply for auto loan", "icon": Icons.drive_eta},
          {"title": "Mortgage", "description": "Your new home waits you!", "icon": Icons.house_outlined},
          {"title": "Transfer History", "description": "Review your loan payments", "icon": Icons.receipt_long_rounded},
        ]
      },
      {"title": "Transfers", "icon": Icons.transform_outlined, "description": ""},
      {"title": "Payments", "icon": Icons.receipt_long_outlined, "description": ""},
      {"title": "Insurance", "icon": Icons.security_rounded, "description": ""},
      {"title": "Investments", "icon": Icons.inventory_2_outlined, "description": ""},
      {"title": "Services", "icon": Icons.money_sharp, "description": ""},
    ];
  }

  static List<Map> menuItemsStatic() {
    return [
      {"title": "Settings", "icon": Icons.settings, "description": ""},
      {"title": "Support", "icon": Icons.headphones_outlined, "description": ""},
      {"title": "Help & Legal", "icon": Icons.live_help_outlined, "description": ""},
    ];
  }

  static List<Map> menuChildItems() {
    return [
      {"title": "My Loans", "description": "Review your loans", "icon": Icons.receipt_long_rounded},
      {"title": "Personal Loans", "description": "Apply for personal loans", "icon": Icons.wallet},
      {"title": "Auto Loans", "description": "Apply for auto loan", "icon": Icons.drive_eta},
      {"title": "Mortgage", "description": "Your new home waits you!", "icon": Icons.house_outlined},
      {"title": "Transfer History", "description": "Review your loan payments", "icon": Icons.receipt_long_rounded},
    ];
  }
}
