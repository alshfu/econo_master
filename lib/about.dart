import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  List<RadioItem> _data = generateItems(3);

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget> _displayTexts = {
      'Русский': RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
                text: '1. Ввод данных:\n',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    'У вас есть четыре текстовых поля, чтобы ввести ваши данные: ставка НДС, цена без НДС, сумма НДС и цена с НДС. Введите любую информацию, которую вы знаете, в соответствующие поля.\n\n'),
            TextSpan(
                text: '2. Выбор режима:\n',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    'Если вы хотите, чтобы калькулятор помог определить ставку НДС, просто поставьте галочку в чекбоксе "Calculate VAT rate". Если этот пункт отмечен, калькулятор автоматически рассчитает ставку НДС на основе остальных данных, которые вы ввели.\n\n'),
            TextSpan(
                text: '3. Автоматические вычисления:\n',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    'Ваш калькулятор автоматически вычислит и заполнит любые недостающие поля, как только вы ввели достаточно информации. Он может вычислить сумму НДС и цену с НДС, используя ставку НДС и цену без НДС, или наоборот, вычислить цену без НДС, используя ставку НДС и сумму НДС.\n\n'),
            TextSpan(
                text: '4. Обновление результатов:\n',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    'Как только все необходимые расчеты выполнены, калькулятор обновит отображаемые значения, чтобы вы могли увидеть результаты.\n'),
          ],
        ),
      ),
      'Svenska': RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
                text: '1. Ange data:\n',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    'Du har fyra textfält för att ange dina data: momsats, pris utan moms, momsbelopp och pris med moms. Ange vilken information du vet i motsvarande fält.\n\n'),
            TextSpan(
                text: '2. Välj läge:\n',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    'Om du vill att kalkylatorn ska hjälpa till att bestämma momssatsen, markera kryssrutan "Calculate VAT rate". Om den här rutan är markerad kommer kalkylatorn automatiskt att beräkna momssatsen baserat på de andra data du har angett.\n\n'),
            TextSpan(
                text: '3. Automatiska beräkningar:\n',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    'Din kalkylator kommer automatiskt att beräkna och fylla i alla saknade fält så snart du har angett tillräckligt med information. Den kan beräkna momssumman och priset med moms med hjälp av momssatsen och priset utan moms, eller tvärtom, beräkna priset utan moms med hjälp av momssatsen och momssumman.\n\n'),
            TextSpan(
                text: '4. Uppdatera resultat:\n',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    'När alla nödvändiga beräkningar har gjorts kommer kalkylatorn att uppdatera de visade värdena så att du kan se resultaten.\n'),
          ],
        ),
      ),
      'English': RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
                text: '1. Enter data:\n',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    'You have four text fields to enter your data: VAT rate, price without VAT, VAT amount, and price with VAT. Enter any information you know into the corresponding fields.\n\n'),
            TextSpan(
                text: '2. Choose mode:\n',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    'If you want the calculator to help determine the VAT rate, simply check the "Calculate VAT rate" checkbox. If this item is checked, the calculator will automatically calculate the VAT rate based on the other data you have entered.\n\n'),
            TextSpan(
                text: '3. Automatic calculations:\n',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    'Your calculator will automatically calculate and fill in any missing fields as soon as you have entered enough information. It can calculate the VAT amount and price with VAT using the VAT rate and price without VAT, or vice versa, calculate the price without VAT using the VAT rate and VAT amount.\n\n'),
            TextSpan(
                text: '4. Update results:\n',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    'Once all necessary calculations are done, the calculator will update the displayed values so you can see the results.\n'),
          ],
        ),
      ),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: ListView(
        children: [
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _data.forEach((item) {
                  item.isExpanded = false;
                });
                _data[index].isExpanded = !isExpanded;
              });
            },
            children: _data.map<ExpansionPanel>((RadioItem item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(item.headerValue),
                  );
                },
                body: ListTile(
                  title: _displayTexts[item.headerValue],
                ),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  static List<RadioItem> generateItems(int numberOfItems) {
    return List<RadioItem>.generate(numberOfItems, (int index) {
      return RadioItem(
        expandedValue: '',
        headerValue: ['English', 'Русский', 'Svenska'][index],
        isExpanded: false,
      );
    });
  }
}

class RadioItem {
  RadioItem({
    required this.expandedValue,
    required this.headerValue,
    required this.isExpanded,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
