import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_models.dart';
import '../providers/app_provider.dart';

class HomeShell extends StatefulWidget { const HomeShell({super.key}); @override State<HomeShell> createState() => _HomeShellState(); }
class _HomeShellState extends State<HomeShell> {
  int idx = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [const DashboardScreen(), const FieldScreen(), const ExpenseScreen(), const DiaryScreen(), const SettingsScreen()];
    return Scaffold(
      body: pages[idx],
      floatingActionButton: FloatingActionButton(onPressed: () { if (idx == 1) _addField(context); if (idx == 2) _addExpense(context); }, child: const Icon(Icons.add)),
      bottomNavigationBar: NavigationBar(selectedIndex: idx, onDestinationSelected: (v) => setState(() => idx = v), destinations: const [
        NavigationDestination(icon: Icon(Icons.dashboard), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.map), label: 'Fields'),
        NavigationDestination(icon: Icon(Icons.currency_rupee), label: 'Expenses'),
        NavigationDestination(icon: Icon(Icons.book), label: 'Diary'),
        NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
      ]),
    );
  }

  void _addField(BuildContext context) => showDialog(context: context, builder: (_) => const _FieldDialog());
  void _addExpense(BuildContext context) => showDialog(context: context, builder: (_) => const _ExpenseDialog());
}

class DashboardScreen extends StatelessWidget { const DashboardScreen({super.key}); @override Widget build(BuildContext context) { final p = context.watch<AppProvider>(); final total = p.expenses.fold<double>(0, (a,b)=>a+b.amount); return SafeArea(child: ListView(padding: const EdgeInsets.all(16), children:[Text('Kisan Dashboard', style: Theme.of(context).textTheme.headlineSmall), const SizedBox(height: 12), Wrap(spacing: 8, runSpacing: 8, children:[_kpi('Fields', p.fields.length.toString()), _kpi('Expenses', '₹${total.toStringAsFixed(0)}'), _kpi('Reminders', p.reminders.length.toString())]), const SizedBox(height: 16), SizedBox(height: 180, child: Card(child: Padding(padding: const EdgeInsets.all(12), child: BarChart(BarChartData(barGroups: List.generate(4, (i)=>BarChartGroupData(x: i, barRods:[BarChartRodData(toY: (i+1)*12)])))))))])); }
Widget _kpi(String t,String v)=>Card(child:SizedBox(width:110,height:90,child:Center(child:Column(mainAxisAlignment: MainAxisAlignment.center,children:[Text(v,style: const TextStyle(fontSize:20,fontWeight: FontWeight.bold)),Text(t)])))); }

class FieldScreen extends StatelessWidget { const FieldScreen({super.key}); @override Widget build(BuildContext context) { final data=context.watch<AppProvider>().fields; return SafeArea(child:ListView(padding: const EdgeInsets.all(16), children:[const Text('Fields', style: TextStyle(fontSize:24,fontWeight: FontWeight.bold)),...data.map((f)=>Card(child:ListTile(leading: const Icon(Icons.terrain),title: Text(f.name),subtitle: Text('${f.crop} • ${f.size}\n${f.lat}, ${f.lng}'))))])); }}
class ExpenseScreen extends StatelessWidget { const ExpenseScreen({super.key}); @override Widget build(BuildContext context) { final data=context.watch<AppProvider>().expenses; return SafeArea(child:ListView(padding: const EdgeInsets.all(16), children:[const Text('Expenses', style: TextStyle(fontSize:24,fontWeight: FontWeight.bold)),...data.map((e)=>Card(child:ListTile(title: Text(e.type.name),subtitle: Text(e.notes),trailing: Text('₹${e.amount}'))))])); }}
class DiaryScreen extends StatelessWidget { const DiaryScreen({super.key}); @override Widget build(BuildContext context) { final p=context.watch<AppProvider>(); return SafeArea(child:ListView(padding: const EdgeInsets.all(16), children:[const Text('Farming Diary & Smart Tools', style: TextStyle(fontSize:22,fontWeight: FontWeight.bold)),Card(child:ListTile(title: const Text('Yield Prediction'),subtitle: const Text('Area 2.5 x Productivity 14'),trailing: Text('${SmartCalc.yieldEstimate(2.5,14)} qtl'))),Card(child:ListTile(title: const Text('Profit / Loss'),subtitle: const Text('Income 60,000 - Cost 38,000'),trailing: Text('₹${SmartCalc.profitLoss(60000,38000)}'))),...p.diary.map((d)=>Card(child:ListTile(title: Text(d.text),subtitle: Text(d.date.toString())))),FilledButton(onPressed:(){p.addDiary(DiaryRecord(id: DateTime.now().microsecondsSinceEpoch.toString(), date: DateTime.now(), text: 'Watered wheat and checked soil moisture.'));}, child: const Text('Add Quick Entry'))])); }}
class SettingsScreen extends StatelessWidget { const SettingsScreen({super.key}); @override Widget build(BuildContext context) { final p=context.watch<AppProvider>(); return SafeArea(child:ListView(padding: const EdgeInsets.all(16), children:[const Text('Settings', style: TextStyle(fontSize:24,fontWeight: FontWeight.bold)),SwitchListTile(value: p.mode==ThemeMode.dark,onChanged: p.toggleTheme,title: const Text('Dark mode')),ListTile(title: const Text('Language'),subtitle: Text(p.lang),trailing: DropdownButton<String>(value: p.lang, items: const [DropdownMenuItem(value:'hi',child:Text('Hindi')),DropdownMenuItem(value:'en',child:Text('English'))], onChanged:(v){if(v!=null)p.setLang(v);})),ListTile(title: const Text('Currency'),subtitle: Text(p.currency)),const Card(child: ListTile(title: Text('Backup/Restore'), subtitle: Text('Export local JSON backup from device storage.')))])); }}

class _FieldDialog extends StatefulWidget { const _FieldDialog(); @override State<_FieldDialog> createState()=>_FieldDialogState(); }
class _FieldDialogState extends State<_FieldDialog>{ final n=TextEditingController(); final c=TextEditingController(); @override Widget build(BuildContext context){ return AlertDialog(title: const Text('Add Field'),content: Column(mainAxisSize: MainAxisSize.min,children:[TextField(controller:n,decoration: const InputDecoration(labelText:'Field name')),TextField(controller:c,decoration: const InputDecoration(labelText:'Crop'))]),actions:[TextButton(onPressed:()=>Navigator.pop(context), child: const Text('Cancel')),FilledButton(onPressed:(){context.read<AppProvider>().addField(FieldRecord(id:DateTime.now().microsecondsSinceEpoch.toString(),name:n.text,lat:28.61,lng:77.20,size:'1 acre',crop:c.text,soil:'Loam',notes:'Map feature placeholder'));Navigator.pop(context);}, child: const Text('Save'))]); }}
class _ExpenseDialog extends StatefulWidget { const _ExpenseDialog(); @override State<_ExpenseDialog> createState()=>_ExpenseDialogState(); }
class _ExpenseDialogState extends State<_ExpenseDialog>{ final a=TextEditingController(); @override Widget build(BuildContext context){ return AlertDialog(title: const Text('Add Expense'),content: TextField(controller:a,keyboardType: TextInputType.number,decoration: const InputDecoration(labelText:'Amount')),actions:[TextButton(onPressed:()=>Navigator.pop(context), child: const Text('Cancel')),FilledButton(onPressed:(){context.read<AppProvider>().addExpense(ExpenseRecord(id:DateTime.now().microsecondsSinceEpoch.toString(), type: ExpenseType.fertilizer, amount: double.tryParse(a.text)??0, date: DateTime.now(), notes: 'Quick add'));Navigator.pop(context);}, child: const Text('Save'))]); }}
