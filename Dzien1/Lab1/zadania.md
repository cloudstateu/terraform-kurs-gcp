# Szkolenie Terraform: Dzień 1

## Zadanie 1 - Provider

Celem tego zadania laboratoryjnego jest nauczenie się konfigurowania providera Google oraz pobierania istniejących
zasobów przy pomocy bloku data w chmurze GCP.

W ramach zadania należy skonfigurować providera Google oraz pobrać istniejący projekt według przekazanych dostępów.

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. Zaloguj się z wykorzystaniem przypisanego do Ciebie konta do portalu GCP pod adresem `https://console.cloud.google.com`. Następnie w nowym oknie otwórz Cloud Shell
   Editor np. poprzez wskazany link `https://ide.cloud.google.com`.
2. Przygotuj folder dla swoich plików Terraform. W nim utwórz plik `providers.tf` i skonfiguruj w nim providera Google. Zwróć uwagę, aby w konfiguracji providera wskazać
   odpowiedni projekt (przypisany do twojego konta) oraz region `europe-west1`. Wskaż użycie konkretnej wersji providera: `5.40.0`.
3. Wykonaj inicjalizację konfiguracji przy pomocy komendy `terraform init`.
4. Utwórz plik `data.tf` i dodaj w nim blok data typu `google_project`. Skonfiguruj go zgodnie z dokumentacją, tak aby pobrać Twój projekt.
5. Uruchom polecenie `terraform plan`, aby sprawdzić, czy Terraform wykrył grupę zasobów i czy nie ma błędów w konfiguracji.
6. Uruchom polecenie `terraform apply`. Terraform pobierze istniejącą grupę zasobów z Azure, zapisze ją w stanie i zakończy działanie bez wprowadzania żadnych zmian.
7. Sprawdź, co zostało zapisane w pliku stanu po uruchomieniu polecenia `terraform apply`.

Pomocne linki:

* [Dokumentacja providera Google](https://registry.terraform.io/providers/hashicorp/google/5.43.1/docs/guides/provider_reference)
* [Data google_projectp](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project)


## Zadanie 2 - Remote Backend

Celem tego zadania jest nauka konfiguracji backend'u tak aby przechowywać i zarządzać plikiem stanu zdalnie.

W tym celu wykorzystamy usługę Storage Account, w której będziemy przechowywać stan naszej infrastruktury chmurowej.
Pamiętaj, że nazwa instancji Storage Account **musi być unikalna globalnie.**

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. Otwórz portal Azure. Upewnij się, że jesteś zalogowany do tenant'a wykorzystywanego w trakcie bieżącego kursu i 
   widzisz swoją grupę zasobów.
2. Stwórz ręcznie Storage Account w swojej grupie zasobów, wykorzystaj ustawienia domyślne.
3. Nadaj swojemu użytkownikowi rolę Storage Blob Data Owner na poziomie utworzonego Storage.
4. W nowo utworzonym storage'u stwórz kontener o nazwie `tfstate`.
5. W folderze z Twoją konfiguracją Terraform, utwórz nowy folder i skopiuj do niego pliki `.tf` z kodem z poprzedniego zadania.
6. Utwórz nowy plik `backend.tf` i skonfiguruj blok backend `azurerm` wskazujac nowy kontener. Na potrzeby naszego
   laboratorium wykorzystaj metodę autentykacji do storage'a poprzez Twoje konto Azure AD.
7. Przejdź do nowego katalogu i wykonaj inicjalizację konfiguracji przy pomocy komendy `terraform init`.
8. Uruchom polecenie `terraform plan` aby sprawdzić, czy Terraform wykrył grupę zasobów i czy nie ma błędów w konfiguracji.
9. Uruchom polecenie `terraform apply`. Terraform pobierze istniejącą grupę zasobów z Azure, zapisze ją w stanie i
   zakończy działanie bez wprowadzania żadnych zmian.
10. Sprawdź, co zostało zapisane w zdalnym pliku stanu (w kontenerze) po uruchomieniu polecenia `terraform apply`.

Pomocne linki:

* [Dokumentacja backend azurerm](https://developer.hashicorp.com/terraform/language/settings/backends/azurerm)
