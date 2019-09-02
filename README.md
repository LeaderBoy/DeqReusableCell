# DeqReusableCell

### 注册复用的cell

正常情况下使用tableview查找复用cell
```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
  if cell == nil {
    cell = UITableView(frame: self.bounds, style: UITableView.Style.grouped)
  }
  return cell!
}
```

### 使用本文件注册
```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let cell = tableView.dequeueReusableClassCell(UITableViewCell.self)
  return cell
}
```


