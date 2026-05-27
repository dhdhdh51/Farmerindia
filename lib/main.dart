import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('kisan_ledger');
  runApp(const KisanLedgerApp());
}

class KisanLedgerApp extends StatelessWidget {
  const KisanLedgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState()..init(),
      child: Consumer<AppState>(
        builder: (_, state, __) {
          return MaterialApp(
            title: 'Kisan Ledger',
            debugShowCheckedModeBanner: false,
            locale: Locale(state.languageCode),
            themeMode: state.themeMode,
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.green,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.green,
              brightness: Brightness.dark,
            ),
            home: state.ready ? (state.onboarded ? const HomeShell() : const OnboardingScreen()) : const SplashScreen(),
          );
        },
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  final box = Hive.box('kisan_ledger');
  bool ready = false;
  bool onboarded = false;
  ThemeMode themeMode = ThemeMode.system;
  String languageCode = 'en';
  String currency = '₹';

  List<Map<String, dynamic>> fields = [];
  List<Map<String, dynamic>> expenses = [];
  List<Map<String, dynamic>> fertilizers = [];
  List<Map<String, dynamic>> watering = [];
  List<Map<String, dynamic>> diary = [];

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    onboarded = prefs.getBool('onboarded') ?? false;
    languageCode = prefs.getString('lang') ?? 'en';
    currency = prefs.getString('currency') ?? '₹';
    final dark = prefs.getBool('dark');
    themeMode = dark == null ? ThemeMode.system : (dark ? ThemeMode.dark : ThemeMode.light);

    fields = List<Map<String, dynamic>>.from((box.get('fields') ?? []).map((e) => Map<String, dynamic>.from(e)));
    expenses = List<Map<String, dynamic>>.from((box.get('expenses') ?? []).map((e) => Map<String, dynamic>.from(e)));
    fertilizers = List<Map<String, dynamic>>.from((box.get('fertilizers') ?? []).map((e) => Map<String, dynamic>.from(e)));
    watering = List<Map<String, dynamic>>.from((box.get('watering') ?? []).map((e) => Map<String, dynamic>.from(e)));
    diary = List<Map<String, dynamic>>.from((box.get('diary') ?? []).map((e) => Map<String, dynamic>.from(e)));

    ready = true;
    notifyListeners();
  }

  Future<void> setOnboarded() async {
    onboarded = true;
    (await SharedPreferences.getInstance()).setBool('onboarded', true);
    notifyListeners();
  }

  Future<void> setTheme(bool dark) async {
    themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    (await SharedPreferences.getInstance()).setBool('dark', dark);
    notifyListeners();
  }

  Future<void> setLanguage(String code) async {
    languageCode = code;
    (await SharedPreferences.getInstance()).setString('lang', code);
    notifyListeners();
  }

  Future<void> setCurrency(String value) async {
    currency = value;
    (await SharedPreferences.getInstance()).setString('currency', value);
    notifyListeners();
  }

  void addItem(String key, Map<String, dynamic> item, List<Map<String, dynamic>> list) {
    list.insert(0, item);
    box.put(key, list);
    notifyListeners();
  }

  double get totalExpenses => expenses.fold(0, (sum, e) => sum + (e['amount'] as num).toDouble());

  Map<String, double> expenseByCategory() {
    final out = <String, double>{};
    for (final e in expenses) {
      final k = e['category'] as String;
      out[k] = (out[k] ?? 0) + (e['amount'] as num).toDouble();
    }
    return out;
  }

  String exportJson() => jsonEncode({
        'fields': fields,
        'expenses': expenses,
        'fertilizers': fertilizers,
        'watering': watering,
        'diary': diary,
      });

  Future<void> importJson(String data) async {
    final m = jsonDecode(data);
    fields = List<Map<String, dynamic>>.from((m['fields'] ?? []).map((e) => Map<String, dynamic>.from(e)));
    expenses = List<Map<String, dynamic>>.from((m['expenses'] ?? []).map((e) => Map<String, dynamic>.from(e)));
    fertilizers = List<Map<String, dynamic>>.from((m['fertilizers'] ?? []).map((e) => Map<String, dynamic>.from(e)));
    watering = List<Map<String, dynamic>>.from((m['watering'] ?? []).map((e) => Map<String, dynamic>.from(e)));
    diary = List<Map<String, dynamic>>.from((m['diary'] ?? []).map((e) => Map<String, dynamic>.from(e)));
    await box.put('fields', fields);
    await box.put('expenses', expenses);
    await box.put('fertilizers', fertilizers);
    await box.put('watering', watering);
    await box.put('diary', diary);
    notifyListeners();
  }
}

class SplashScreen extends StatelessWidget { const SplashScreen({super.key}); @override Widget build(BuildContext c)=>const Scaffold(body: Center(child: CircularProgressIndicator())); }

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF66BB6A)])),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.agriculture, size: 96, color: Colors.white),
            const SizedBox(height: 12),
            const Text('Kisan Ledger', style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => context.read<AppState>().setOnboarded(),
              child: const Text('Start / शुरू करें'),
            )
          ]),
        ),
      ),
    );
  }
}

class HomeShell extends StatefulWidget { const HomeShell({super.key}); @override State<HomeShell> createState()=>_HomeShellState(); }
class _HomeShellState extends State<HomeShell>{int i=0; final pages=[const DashboardScreen(),const FieldListScreen(),const ExpenseScreen(),const ReportsScreen(),const SettingsScreen()];
  @override Widget build(BuildContext c)=>Scaffold(body: pages[i], bottomNavigationBar: NavigationBar(selectedIndex: i,onDestinationSelected:(v)=>setState(()=>i=v),destinations: const [NavigationDestination(icon: Icon(Icons.home), label:'Home'),NavigationDestination(icon: Icon(Icons.map), label:'Fields'),NavigationDestination(icon: Icon(Icons.currency_rupee), label:'Expense'),NavigationDestination(icon: Icon(Icons.bar_chart), label:'Reports'),NavigationDestination(icon: Icon(Icons.settings), label:'Settings')]));}

class DashboardScreen extends StatelessWidget { const DashboardScreen({super.key});
  @override Widget build(BuildContext c){final s=c.watch<AppState>();
    return Scaffold(appBar: AppBar(title: const Text('Dashboard')),floatingActionButton: FloatingActionButton(onPressed: ()=>Navigator.push(c, MaterialPageRoute(builder:(_)=>const AddDiaryScreen())),child: const Icon(Icons.note_add)), body: ListView(padding: const EdgeInsets.all(16), children:[Wrap(spacing:12,runSpacing:12,children:[stat('Fields', '${s.fields.length}'),stat('Expenses', '${s.currency}${s.totalExpenses.toStringAsFixed(0)}'),stat('Fertilizer', '${s.fertilizers.length}'),stat('Watering', '${s.watering.length}')]), const SizedBox(height:16), const Text('Monthly Expense Overview'), SizedBox(height:180, child: LineChart(LineChartData(lineBarsData:[LineChartBarData(spots: List.generate(6, (idx)=>FlSpot(idx.toDouble(), (s.totalExpenses/(idx+2)).clamp(100, 5000))), isCurved:true)]))), const SizedBox(height:16), const Text('Smart Tips'), const Card(child: Padding(padding: EdgeInsets.all(12), child: Text('Use soil testing before fertilizer application. / खाद डालने से पहले मिट्टी जांच करें।'))), ]));}
  Widget stat(String t,String v)=>Container(width:160,padding: const EdgeInsets.all(16),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),gradient: const LinearGradient(colors:[Color(0xAAFFFFFF),Color(0x55A5D6A7)])),child: Column(crossAxisAlignment: CrossAxisAlignment.start,children:[Text(t),Text(v,style: const TextStyle(fontSize:22,fontWeight: FontWeight.bold))]));
}

class FieldListScreen extends StatelessWidget { const FieldListScreen({super.key});
  @override Widget build(BuildContext c){final s=c.watch<AppState>(); return Scaffold(appBar: AppBar(title: const Text('Fields')),floatingActionButton: FloatingActionButton(onPressed: ()=>Navigator.push(c, MaterialPageRoute(builder:(_)=>const AddFieldScreen())),child: const Icon(Icons.add)), body: GridView.builder(padding: const EdgeInsets.all(16),gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1.15,crossAxisSpacing: 10,mainAxisSpacing: 10),itemCount: s.fields.length,itemBuilder:(_,i){final f=s.fields[i]; return Card(child: Padding(padding: const EdgeInsets.all(10), child: Column(crossAxisAlignment: CrossAxisAlignment.start,children:[Text(f['name'], style: const TextStyle(fontWeight: FontWeight.bold)),Text('Crop: ${f['crop']}'),Text('Soil: ${f['soil']}'),Text('Size: ${f['size']} ${f['unit']}'),Text('Lat: ${f['lat'].toStringAsFixed(3)}')]))); })); }
}

class AddFieldScreen extends StatefulWidget { const AddFieldScreen({super.key}); @override State<AddFieldScreen> createState()=>_AddFieldScreenState(); }
class _AddFieldScreenState extends State<AddFieldScreen>{final n=TextEditingController(); final crop=TextEditingController(); final soil=TextEditingController(); final size=TextEditingController(); String unit='acre'; LatLng point=const LatLng(28.6139,77.2090); String? imagePath;
  @override Widget build(BuildContext c)=>Scaffold(appBar: AppBar(title: const Text('Add Field')), body: ListView(padding: const EdgeInsets.all(16),children:[TextField(controller:n,decoration: const InputDecoration(labelText:'Field Name')),TextField(controller:crop,decoration: const InputDecoration(labelText:'Crop')),TextField(controller:soil,decoration: const InputDecoration(labelText:'Soil')),TextField(controller:size,keyboardType: TextInputType.number,decoration: const InputDecoration(labelText:'Size')),DropdownButtonFormField(value:unit,items:['bigha','acre','hectare'].map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(),onChanged:(v)=>setState(()=>unit=v!)),const SizedBox(height:8),SizedBox(height:220, child: FlutterMap(options: MapOptions(initialCenter: point, initialZoom: 12, onTap: (_,p)=>setState(()=>point=p)), children:[TileLayer(urlTemplate:'https://tile.openstreetmap.org/{z}/{x}/{y}.png'), MarkerLayer(markers:[Marker(point: point, width: 40, height: 40, child: const Icon(Icons.location_pin,color: Colors.red))])])),TextButton(onPressed: () async {final x = await ImagePicker().pickImage(source: ImageSource.gallery); if(x!=null)setState(()=>imagePath=x.path);}, child: Text(imagePath==null?'Pick Field Image':'Image Selected')),FilledButton(onPressed: (){c.read<AppState>().addItem('fields', {'name':n.text,'crop':crop.text,'soil':soil.text,'size':double.tryParse(size.text)??0,'unit':unit,'lat':point.latitude,'lng':point.longitude,'image':imagePath,'notes':''}, c.read<AppState>().fields); Navigator.pop(c);}, child: const Text('Save'))]));}

class ExpenseScreen extends StatefulWidget { const ExpenseScreen({super.key}); @override State<ExpenseScreen> createState()=>_ExpenseScreenState(); }
class _ExpenseScreenState extends State<ExpenseScreen>{final amount=TextEditingController();final notes=TextEditingController(); String cat='Seeds';
  @override Widget build(BuildContext c){final s=c.watch<AppState>(); final stats=s.expenseByCategory(); return Scaffold(appBar: AppBar(title: const Text('Expenses')), body: ListView(padding: const EdgeInsets.all(16),children:[DropdownButtonFormField(value:cat,items:['Seeds','Fertilizer','Diesel','Watering','Labour','Tractor/Ploughing','Pesticides','Other'].map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(),onChanged:(v)=>setState(()=>cat=v!)),TextField(controller:amount,keyboardType: TextInputType.number,decoration: const InputDecoration(labelText:'Amount')),TextField(controller:notes,decoration: const InputDecoration(labelText:'Notes')),FilledButton(onPressed:(){c.read<AppState>().addItem('expenses', {'category':cat,'amount':double.tryParse(amount.text)??0,'date':DateTime.now().toIso8601String(),'notes':notes.text}, c.read<AppState>().expenses);}, child: const Text('Add Expense')),const SizedBox(height:12),SizedBox(height:200, child: PieChart(PieChartData(sections: stats.entries.map((e)=>PieChartSectionData(value:e.value,title:e.key.substring(0,1))).toList()))),...s.expenses.map((e)=>ListTile(title: Text('${e['category']} - ${s.currency}${e['amount']}'),subtitle: Text(DateFormat.yMMMd().format(DateTime.parse(e['date']))))).toList() ]));}
}

class ReportsScreen extends StatelessWidget { const ReportsScreen({super.key});
  @override Widget build(BuildContext c){final s=c.watch<AppState>(); final month=DateFormat('MMM yyyy').format(DateTime.now()); return Scaffold(appBar: AppBar(title: const Text('Reports')), body: ListView(padding: const EdgeInsets.all(16),children:[Card(child: ListTile(title: Text('Monthly Expense ($month)'),subtitle: Text('${s.currency}${s.totalExpenses.toStringAsFixed(2)}'))),FilledButton(onPressed: () async {final dir=await getApplicationDocumentsDirectory(); final file='${dir.path}/kisan_backup.json'; await Future<void>.delayed(const Duration(milliseconds: 200)); ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text('PDF placeholder exported to $file')));}, child: const Text('Export PDF (Local Placeholder)')),ListTile(title: const Text('Backup & Restore'),trailing: const Icon(Icons.chevron_right),onTap: ()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>const BackupRestoreScreen()))),ListTile(title: const Text('Fertilizer Scheduler'),trailing: const Icon(Icons.chevron_right),onTap: ()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>const FertilizerScreen()))),ListTile(title: const Text('Watering Tracker'),trailing: const Icon(Icons.chevron_right),onTap: ()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>const WateringScreen()))),])); }
}

class FertilizerScreen extends StatefulWidget { const FertilizerScreen({super.key}); @override State<FertilizerScreen> createState()=>_FertilizerScreenState(); }
class _FertilizerScreenState extends State<FertilizerScreen>{final name=TextEditingController();final qty=TextEditingController();final days=TextEditingController(text:'15');
@override Widget build(BuildContext c){final s=c.watch<AppState>();return Scaffold(appBar: AppBar(title: const Text('Fertilizer Scheduler')),body: ListView(padding: const EdgeInsets.all(16),children:[TextField(controller:name,decoration: const InputDecoration(labelText:'Fertilizer')),TextField(controller:qty,decoration: const InputDecoration(labelText:'Quantity')),TextField(controller:days,keyboardType: TextInputType.number,decoration: const InputDecoration(labelText:'Next after days')),FilledButton(onPressed:(){final now=DateTime.now();final next=now.add(Duration(days:int.tryParse(days.text)??15)); c.read<AppState>().addItem('fertilizers', {'name':name.text,'qty':qty.text,'date':now.toIso8601String(),'next':next.toIso8601String()}, c.read<AppState>().fertilizers);}, child: const Text('Save Reminder')), ...s.fertilizers.map((f)=>ListTile(title: Text(f['name']),subtitle: Text('Next: ${DateFormat.yMMMd().format(DateTime.parse(f['next']))}')))]));}}

class WateringScreen extends StatefulWidget { const WateringScreen({super.key}); @override State<WateringScreen> createState()=>_WateringScreenState(); }
class _WateringScreenState extends State<WateringScreen>{final source=TextEditingController();final hrs=TextEditingController();
@override Widget build(BuildContext c){final s=c.watch<AppState>();return Scaffold(appBar: AppBar(title: const Text('Watering Tracker')),body: ListView(padding: const EdgeInsets.all(16),children:[TextField(controller:source,decoration: const InputDecoration(labelText:'Water Source')),TextField(controller:hrs,keyboardType: TextInputType.number,decoration: const InputDecoration(labelText:'Motor Hours')),FilledButton(onPressed:(){c.read<AppState>().addItem('watering', {'source':source.text,'hours':double.tryParse(hrs.text)??0,'date':DateTime.now().toIso8601String(),'next':DateTime.now().add(const Duration(days:3)).toIso8601String()}, c.read<AppState>().watering);}, child: const Text('Save Watering')), ...s.watering.map((w)=>ListTile(title: Text(w['source']),subtitle: Text('Next: ${DateFormat.yMMMd().format(DateTime.parse(w['next']))}')))]));}}

class BackupRestoreScreen extends StatelessWidget { const BackupRestoreScreen({super.key});
  @override Widget build(BuildContext c){final s=c.watch<AppState>(); final ctrl=TextEditingController(); return Scaffold(appBar: AppBar(title: const Text('Backup & Restore')),body: Padding(padding: const EdgeInsets.all(16),child: Column(children:[FilledButton(onPressed: (){ctrl.text=s.exportJson();}, child: const Text('Export JSON')),TextField(controller: ctrl,maxLines: 10,decoration: const InputDecoration(hintText:'Paste backup JSON')),FilledButton(onPressed: () async {await c.read<AppState>().importJson(ctrl.text);}, child: const Text('Import JSON'))]))); }
}

class AddDiaryScreen extends StatefulWidget { const AddDiaryScreen({super.key}); @override State<AddDiaryScreen> createState()=>_AddDiaryScreenState(); }
class _AddDiaryScreenState extends State<AddDiaryScreen>{final t=TextEditingController();
@override Widget build(BuildContext c){final s=c.watch<AppState>();return Scaffold(appBar: AppBar(title: const Text('Farming Diary')),body: ListView(padding: const EdgeInsets.all(16),children:[TextField(controller:t,decoration: const InputDecoration(labelText:'Daily Notes')),FilledButton(onPressed:(){c.read<AppState>().addItem('diary', {'note':t.text,'date':DateTime.now().toIso8601String()}, c.read<AppState>().diary);}, child: const Text('Save Entry')), ...s.diary.map((d)=>ListTile(title: Text(d['note']),subtitle: Text(DateFormat.yMMMd().format(DateTime.parse(d['date'])))))]));}}

class SettingsScreen extends StatelessWidget { const SettingsScreen({super.key});
  @override Widget build(BuildContext c){final s=c.watch<AppState>(); return Scaffold(appBar: AppBar(title: const Text('Settings')), body: ListView(children:[SwitchListTile(value:s.themeMode==ThemeMode.dark,title: const Text('Dark mode'),onChanged:(v)=>c.read<AppState>().setTheme(v)),ListTile(title: const Text('Language'),subtitle: Text(s.languageCode),trailing: DropdownButton(value:s.languageCode,items: const [DropdownMenuItem(value:'en',child:Text('English')),DropdownMenuItem(value:'hi',child:Text('हिंदी'))],onChanged:(v)=>c.read<AppState>().setLanguage(v!))),ListTile(title: const Text('Currency'),trailing: DropdownButton(value:s.currency,items: const [DropdownMenuItem(value:'₹',child:Text('₹ INR')),DropdownMenuItem(value:'$',child:Text('4 USD'))],onChanged:(v)=>c.read<AppState>().setCurrency(v!))),ListTile(title: const Text('Reset All Data'),onTap: (){s.box.clear(); Navigator.pushAndRemoveUntil(c, MaterialPageRoute(builder:(_)=>const KisanLedgerApp()), (_)=>false);})])); }
}

class NotificationService {
  final FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  Future<void> init() async {
    const settings = InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    await plugin.initialize(settings);
  }
}
