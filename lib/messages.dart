
class AttachmentItem {
  String id = "";
  String mimetype = "";
  String filename = "";
  int size = 0;

  AttachmentItem(this.id, this.mimetype, this.filename, this.size);

  AttachmentItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filename = json['filename'];
    mimetype = json['mimetype'];
    size = json['size'];
  }
}

class BlockItem {
  String id = "";
  String type = "";
  String encoding = "";
  int size = 0;

  BlockItem(this.id, this.type, this.encoding, this.size);

  BlockItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encoding = json['encoding'];
    type = json['type'];
    size = json['size'];
  }
}

class MessageItem {
  String fromName = "";
  String fromAddress = "";
  DateTime date = DateTime.now();
  String subject = "";
  String id = "";
  List<AttachmentItem> attachments = [];
  List<BlockItem> blocks = [];

  MessageItem(this.id, this.date, this.fromName, this.fromAddress, this.subject);

  MessageItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = DateTime.parse(json['date']);
    subject = json['subject'];
    fromAddress = json['from_address'];
    fromName = json['from_name'];

    Iterable a = json['attachments'];
    try {
      attachments = List<AttachmentItem>.from(a.map((m) => AttachmentItem.fromJson(m)));
    } catch (e) {} 

    Iterable b = json['blocks'];
    try { 
      blocks = List<BlockItem>.from(b.map((m) => BlockItem.fromJson(m))); 
    } catch (e) {} 
  }
}