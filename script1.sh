#!/usr/bin/env bash
rm -rf lab0
mkdir -p lab0
cd lab0
mkdir -p claude_monet/pastry_station/oven
mkdir -p claude_monet/pastry_station/cold_room
mkdir -p claude_monet/hall
mkdir -p claude_monet/office
mkdir -p louis_room
mkdir -p empty_boxes

cat << 'EOF' > claude_monet/pastry_station/oven/croissant_plan
Луи замешивает тесто ранним утром
Круассаны должны быть готовы к открытию
В первую партию добавить миндальный крем
Баринов проверит выпечку лично
EOF

cat << 'EOF' > claude_monet/pastry_station/oven/millefeuille_plan
Коржи для мильфея выпекаются отдельно
Луи готовит ванильный крем
Десерт украсят свежими ягодами
Первую порцию подадут Виктору Петровичу
EOF

cat << 'EOF' > claude_monet/pastry_station/cold_room/cream_note
Сливочный крем хранится в холодной комнате
Шоколадный крем нужен для банкета
Луи подписывает каждую ёмкость
Остатки проверяет Лёва после смены
EOF

cat << 'EOF' > claude_monet/pastry_station/dessert_menu
Классический круассан с миндалём
Мильфей с ванильным кремом
Шоколадный торт от Луи
Фирменный десерт Claude Monet
EOF

cat << 'EOF' > claude_monet/hall/banquet_orders
Для банкета приготовить двадцать круассанов
На главный стол подать шоколадный десерт
Гости ждут торт к девятнадцати часам
Вика просит проверить каждый заказ
EOF

cat << 'EOF' > claude_monet/hall/guest_wishes
Постоянный гость просит десерт без орехов
За седьмым столиком ждут мильфей
Детям приготовить небольшие круассаны
Один гость хочет познакомиться с Луи
EOF

cat << 'EOF' > claude_monet/office/barinov_comment
Баринов требует уменьшить количество сахара
Крем должен быть приготовлен перед подачей
Луи отвечает за оформление десертов
Новое меню показать шефу до обеда
EOF

cat << 'EOF' > louis_room/louis_diary
Луи пришёл в кондитерский цех первым
Утром он приготовил любимый десерт Нагиева
После банкета Луи позвонил маме
Вечером весь зал похвалил его торт
EOF

cat << 'EOF' > louis_room/work_schedule
Луи начинает работу в семь часов
До открытия нужно проверить печь
После обеда начинается подготовка банкета
Закрывает кондитерский цех Лёва
EOF

cat << 'EOF' > morning_order
К открытию подготовить свежую выпечку
Вика ждёт список готовых десертов
Баринов проводит проверку в десять часов
Луи передаёт первый заказ официантам
EOF

chmod 755 claude_monet
chmod u=rwx,g=rx,o= claude_monet/pastry_station
chmod 750 claude_monet/pastry_station/oven
chmod u=rw,g=r,o= claude_monet/pastry_station/oven/croissant_plan
chmod 640 claude_monet/pastry_station/oven/millefeuille_plan
chmod u=rwx,g=rx,o= claude_monet/pastry_station/cold_room
chmod 600 claude_monet/pastry_station/cold_room/cream_note
chmod u=rw,g=r,o=r claude_monet/pastry_station/dessert_menu
chmod 755 claude_monet/hall
chmod u=rw,g=rw,o=r claude_monet/hall/banquet_orders
chmod 644 claude_monet/hall/guest_wishes
chmod u=rwx,g=rx,o= claude_monet/office
chmod 640 claude_monet/office/barinov_comment
chmod 750 louis_room
chmod u=r,g=r,o= louis_room/louis_diary
chmod 644 louis_room/work_schedule
chmod u=rwx,g=,o= empty_boxes
chmod u=rw,g=r,o=r morning_order

git add ..
git commit -m "Создание дерева файлов и установка зависимостей"
git push -u origin main

cp louis_room/louis_diary claude_monet/office/confectioner_report
cp -r claude_monet/hall claude_monet/pastry_station/hall_backup
cd louis_room
ln -s ../claude_monet/pastry_station/dessert_menu today_menu
cd ..
ln -s claude_monet/pastry_station dessert_counter
ln morning_order claude_monet/pastry_station/urgent_order
cat claude_monet/pastry_station/oven/croissant_plan claude_monet/pastry_station/oven/millefeuille_plan > claude_monet/pastry_station/baking_plan
cat claude_monet/office/barinov_comment >> claude_monet/pastry_station/dessert_menu
mv claude_monet/hall/guest_wishes claude_monet/office/special_wishes

git add ..
git commit -m "Копирование, перемещение и создание ссылок"
git push

ls -lR | grep "^-" | grep -v "report" | sort -n -k 5 | tail -n 5
grep -rhEi "луи|десерт" claude_monet louis_room | grep -vi "гост" | sort -r | head -n 5
grep -rl "десерт" claude_monet/hall claude_monet/pastry_station/hall_backup | wc -l
tail -q -n 2 claude_monet/pastry_station/oven/*_plan | grep -iE "десерт|порц" | sort
grep -v "Луи" claude_monet/pastry_station/baking_plan | sort -r | head -n 4 | wc -w
ls -lR | grep -E "^-[rwx-]{9} + 2 " | sort -r -k9
ls -lR | grep "^l" | sort -k9 | tail -n 1

rm -f louis_room/louis_diary
rm -f louis_room/today_menu
rm -f dessert_counter
rm -f morning_order
rm -f claude_monet/pastry_station/urgent_order
rm -f claude_monet/pastry_station/cold_room/cream_note
rmdir empty_boxes
rm -rf claude_monet/pastry_station/hall_backup

git add ..
git commit -m "Поиск, фильтрация и обработка данных + Удаление данных"
git push