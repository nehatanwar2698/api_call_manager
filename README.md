

TODO: Api Manager package allows us to call api simple


## Usage
you need to call this function like :



```dart
 Future<void> getPost() async {
    final data = await ApiManager()
        .getData(apiUrl: "https://example.com");
    setState(() => _post = data);
  } 
  ```

## Aditional Information
This package depends on flutter_easyloading :
so you need to do this in material app in main.dart.

```dart
 MaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      
    );
    ```

