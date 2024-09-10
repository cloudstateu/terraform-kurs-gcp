## Zadanie 1 - DNS Zones

Celem tego zadania jest nauczenie się wykorzystywania pętli `for_each`.

Należy utworzyć zmienną lokalną o nazwie `zones`, lub skorzystać z tej utworzonej w zadaniu 6 z dnia 1. Można ją stworzyć od nowa 
lub zmodyfikować istniejącą poprzez dodanie nowych wartości opisanych w dalszej części zadania.
Zmienna powinna mieć typ `map(string)` i zawierać prywatne strefy DNS reprezentujące oddziały biurowe w następujących miastach:
- Kraków
- Warszawa
- Gdańsk
Nazwy stref powinny być tworzone według wzoru *<NAZWA_MIASTA>.kurstf.com.* np. `warszawa.kurstf.com`.
Następnie przy pomocy pętli `for_each` należy utworzyć prywatne strefy DNS przypisane do stworzonej już sieci wirtualnej.
W opisie każdej strefy odwołaj sie do jej pełnej nazwy lub klucza użytego w zmiennej, a także do nazwy sieci wirtualnej.

***Skonfiguruj przekazywanie zapytań DNS wspomnianych stref na konkretny adres IP - `172.16.10.10` Załóżmy, że jest to prywatny 
adres IP serwera DNS naszej firmy. 

Przykład zmiennej lokalnej typu `map(string)`:

```terraform
locals {
  zones = {
    file       = "privatelink.file.core.windows.net"
    postgresql = "privatelink.postgres.database.azure.com"
  }
}
```

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. Wykorzystaj plik Terraform, w którym zdefiniowałeś tworzenie prywatnej strefy DNS w poprzednich zadaniach. Zmodyfikujemy go
   na potrzeby zadania bieżącego.
2. Użyj zmiennej lokalnej o nazwie `zones` typu `map(string)`, w której dodasz nazwy tworzonych stref DNS. Kluczami do nowych
   stref mogą być np. nazwy miast, a wartości nazwy stref według wzoru *<NAZWA_MIASTA>.kurstf.com.* np. `warszawa.kurstf.com`.
3. Zmodyfikuj lub usuń obecny i stwórz nowy zasób typu `dns_managed_zone`. Podczas konfiguracji wykorzystaj pętlę `for_each`. 
   Nazwa strefy powinna być przykazywana jako wartość zmiennej lokalnej, po której będzie iterować Terraform.
4. W nazwie zasobu (argument name) oraz w opisie (description) odwołaj się do klucza zmiennej, po której iterujesz.
5. ***Skonfiguruj przekazywanie zapytań DNS na adres IP `172.16.10.10`. Wyszukaj w dokumentacji zasobu odpowiedniego argumentu.
6. Uruchom polecenie `terraform plan`. Sprawdź, czy Terraform wykrył błędy w konfiguracji.
7. Uruchom polecenie `terraform apply`, aby utworzyć zasoby.
8. Zweryfikuj w portalu, czy utworzenie zasobów przebiegło pomyślnie.
9. ***Sprawdź jak przedstawiony jest zasób wykorzystujący `for_each` w pliku stanu.

***Dla chętnych

Pomocne linki:

* [Pętla for_each](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)
* [Zasób dns_managed_zone](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone)


## Zadanie 2 - Google API

Celem tego zadania jest nauczenie się wykorzystania pętli `count`.

W ramach tego zadania należy utworzyć nową zmienną lokalną `gcp_api` typu `list(string)`. Niech zawiera ona nazwy API,
które będziemy chcieli włączyć:
- iam.googleapis.com
- sqladmin.googleapis.com
- container.googleapis.com
- logging.googleapis.com
- monitoring.googleapis.com
Następnie przy pomocy `google_project_service` i `count` należy włączyć wszystkie wspomniane API.

Przykład zmiennej lokalnej typu `list(string)`:

```terraform
locals {
  passwords = [
    "secretvalue123",
    "secretvalue321"
  ]
}
```

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. Stwórz nowy plik i nazwij go np. `api.tf` i  utwórz nową zmienną lokalną o nazwie `gcp_api` zgodnie z treścią zadania.
2. Dodaj nowy zasób typu `google_project_service`. Podczas konfiguracji wykorzystaj pętlę `count` oraz odpowiednią funkcję. 
   Podając nazwę serwisu odwołaj się do zmiennej lokalnej. Pamiętaj, że przy wykorzystaniu tej pętli możesz odwołać się do 
   konkretnej iteracji przez konstrukcję `count.index`.
3. Uruchom polecenie `terraform plan`. Sprawdź, czy Terraform wykrył błędy w konfiguracji.
4. Uruchom polecenie `terraform apply`, aby wdrożyć zmiany.
5. Zweryfikuj, czy wskazane API zostały poprawnie włączone.
6. Dodaj kolejne pozycje do zmiennej lokalnej np. na początku listy, na końcu i w środku. Uruchom ponownie
   polecenie `terraform plan` i sprawdź, jak zachowa się Terraform wobec aktualnie istniejących zasobów.
7. Sprawdź jak przedstawiony jest zasób wykorzystujący `count` w pliku stanu.

Pomocne linki:

* [Zasób google_project_service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service)
* [Pętla count](https://developer.hashicorp.com/terraform/language/meta-arguments/count)


## Zadanie: 3 - Firewall rules (Zadanie opcjonalne)

Celem tego zadania jest nauczenie się wykorzystywania konstrukcji dynamic blocks.

W ramach tego zadania należy utworzyć reguły firewall dla ruchu wchodzącego (INGRESS) do obecnej podsieci jumphost. W tym celu 
należy wykorzystać zasób `google_compute_firewall` i udynamicznić blok `allow` wykorzystując funkcjonalność dynamic block oraz 
pętlę for_each. Skorzystaj z następującej zmiennej lokalnej zawierającą listę kombinacji protokołów i portów, które należy odblokować:

```terraform
locals {
  protocols_and_ports = [
    {
      protocol = "tcp",
      ports    = ["22"]
    },
    {
      protocol = "udp",
      ports    = ["53"]
    }
  ]
}
```

Aby zrealizować to zadanie, należy wykonać następujące kroki:
1. Utwórz nowy plik np. `fw.tf` i skopiuj do niego zmienną lokalną opisaną powyżej.
2. Zdefiniuj zasób `google_compute_firewall`, w którym wskażesz odwołanie do sieci wirtualnej, odpowiedni kierunek ruchu, 
   który będzie obsługiwany przez reguły oraz zakres podsieci jumphost jako zakres docelowy (destination_ranges).
3. Wewnątrz definicji zasobu stwórz dynamiczny blok `allow`. Za pomocą pętli `for_each` iteruj po nowej zmiennej. Wewnątrz 
   dynamicznego bloku odwołaj się do odpowiednich wartości ze zmiennej.
4. Standardowo uruchom polecenia `terraform plan` aby zweryfikować swoją konifgurację oraz `terraform apply` aby wdrożyć zmiany.
5. Zweryfikuj utworzenie reguł z poziomu portalu.

Pomocne linki:

* [Dokumentacja Dynamic Blocks](https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks)
* [Zasób google_compute_firewall](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)
