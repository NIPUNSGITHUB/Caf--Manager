//
//  ProductViewController.swift
//  WLNI_Wijesinghe-COBSCCOMP192P-029
//
//  Created by Macbook on 4/25/21.
//

import UIKit
import Firebase
import FirebaseStorage
import DropDown
class ProductViewController: UIViewController,UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
   
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var txtDiscount: UITextField!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var switchSellAsItem: UISwitch!
    var imageId = "";
    var selectedimage:UIImage? = nil
    let dropDown = DropDown()
    //var selectedimage:UIImage;
    
    private let db = Database.database().reference();
    var product:[Product] = [
    ]
    var ct:[Category] = [
    ]
    var categoryArr = [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategory()
        // Do any additional setup after loading the view.
    }
    
    func getCategory(){
        let group = DispatchGroup()
                self.db.child("Category").getData { (error, snapshot) in
                     if snapshot.exists() {
                        
                        let dataChange = snapshot.value as! [String:AnyObject]
                        
                        group.wait()
                       
                        dataChange.forEach({ (key,val) in
                           
                            self.categoryArr.append(val as! String)
                        })
                        
                        group.notify(queue: .main) {
                            
                        }
                       // print("Got data",snapshot.value!)
                    }
                }
    }

    @IBAction func categoryDropDown(_ sender: Any) {
      
        dropDown.dataSource = categoryArr
       // dropDown.dataSource =  [ "Tomato soup", "Mini burgers", "Onion rings", "Baked potato", "Salad"]//4
        dropDown.anchorView = sender as! AnchorView //5
        dropDown.bottomOffset = CGPoint(x: 0, y: (sender as AnyObject).frame.size.height) //6
           dropDown.show() //7
           dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
             guard let _ = self else { return }
            (sender as AnyObject).setTitle(item, for: .normal) //9
           }
        
    }
    @IBAction func btnImgUpload(_ sender: Any) {
        
        var imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        imagePickerController.modalPresentationStyle = .fullScreen
                present(imagePickerController,animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        picker.dismiss(animated: true, completion: nil)
        self.selectedimage = info[.originalImage] as! UIImage
        //we should resize the image or takes very lont time for image upload
        self.selectedimage = resizeImage(image: self.selectedimage!, targetSize: CGSize(width: imgProduct.frame.width, height: imgProduct.frame.height))
        self.imgProduct.image = selectedimage
        self.imageId = UUID().uuidString
    }
 
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDiscountChange(_ sender: Any) {
         if let int = Int(txtDiscount.text!)
        {
            
        }
        else
         {
            txtDiscount.text = "";
         }
    }
    
    @IBAction func txtPriceChange(_ sender: Any) {
        if let int = Int(txtPrice.text!)
       {
           
       }
       else
        {
            txtPrice.text = "";
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
            let size = image.size

            let widthRatio  = targetSize.width  / size.width
            let heightRatio = targetSize.height / size.height

            // Figure out what our orientation is, and use that to form the rectangle
            var newSize: CGSize
            if(widthRatio > heightRatio) {
                newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            } else {
                newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
            }

            // This is the rect that we've calculated out and this is what is actually used below
            let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

            // Actually do the resizing to the rect using the ImageContext stuff
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            image.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return newImage!
        }
    
    @IBAction func btnAddProduct(_ sender: Any) {
//        let pro = Product(
//            name: txtName.text,
//            description: txtDescription.text,
//            price: txtPrice.text,
//            discount: txtDiscount.text
//        )
//        product.append(pro)
        
        
        if txtName.text == "" {
            Toast(Title: "Information", Text: "Product name is manditary", delay: 1)
           
        }
        else if txtDescription.text == ""
        {
            Toast(Title: "Information", Text: "Product description is manditary", delay: 1)
        }
        else if txtPrice.text == ""
        {
            Toast(Title: "Information", Text: "Product price is manditary", delay: 1)
        }
        else if self.selectedimage?.pngData() == nil
        {
            Toast(Title: "Information", Text: "Product image is manditary", delay: 1)
        }
        else if dropDown.selectedItem == nil
        {
            Toast(Title: "Information", Text: "Product category is manditary", delay: 1)
        }
        else
        {
            let group = DispatchGroup()
                let child = UUID().uuidString
                self.db.child("Product").child(child).child("name").setValue(txtName.text);
                self.db.child("Product").child(child).child("description").setValue(txtDescription.text);
                self.db.child("Product").child(child).child("price").setValue(txtPrice.text);
                self.db.child("Product").child(child).child("discount").setValue(txtDiscount.text != "" ? txtDiscount.text : 0);
                self.db.child("Product").child(child).child("image").setValue("/\(child).jpg");
                self.db.child("Product").child(child).child("category").setValue(dropDown.selectedItem!);
                self.db.child("Product").child(child).child("sellAsItem").setValue(switchSellAsItem.isOn ? 1 : 0);
                uploadImage(imageId:child)
                group.wait()
            
                group.notify(queue: .main) {
                    self.Toast(Title: "Success", Text: "Successfuly Created!", delay: 1)
                    self.resetFeilds()
                }
                
        }
    }
    
    func resetFeilds() {
        txtName.text = "";
        txtDescription.text = "";
        txtPrice.text = "";
        txtDiscount.text = "";
        selectedimage = nil;
        imgProduct.image = selectedimage;
    }
    
    func uploadImage(imageId:String) {
        let storage = Storage.storage()
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        storage.reference(withPath:  "/\(imageId).jpg")
                  //saving the profile image by user image id as png file
            .putData(self.selectedimage!.pngData()!, metadata: metaData) {metaData,error in
                      if error == nil{

                        self.imgProduct.image = self.selectedimage
                          self.imageId=imageId

                      }else{
                          print(error)

                    }
                self.btnUpload.isEnabled=true
        }
    }
    
    func Toast(Title:String ,Text:String, delay:Int) -> Void {
            let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
            self.present(alert, animated: true)
            let deadlineTime = DispatchTime.now() + .seconds(delay)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                alert.dismiss(animated: true, completion: nil)
            })
        }
     
}
