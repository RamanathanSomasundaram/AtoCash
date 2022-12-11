//
// Copyright (c) 2018 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//-------------------------------------------------------------------------------------------------------------------------------------------------
class File: NSObject {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func name(_ name: String, _ ext: String) -> String {

        return "\(name).\(ext)"
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func temp(ext: String) -> String {

        let timestamp = Date().timestamp()
        let file = "\(timestamp).\(ext)"
        return Dir.cache(file)
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func docSave(name: String) -> URL {
        var tempURL = URL(fileURLWithPath: Dir.document())
        tempURL.appendPathComponent(name)
        return tempURL
    }
    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func exist(path: String) -> Bool {

        return FileManager.default.fileExists(atPath: path)
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func remove(path: String) {

        try? FileManager.default.removeItem(at: URL(fileURLWithPath: path))
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func copy(src: String, dest: String, overwrite: Bool) {

        if (overwrite) { remove(path: dest) }

        if (exist(path: dest) == false) {
            try? FileManager.default.copyItem(atPath: src, toPath: dest)
        }
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func created(path: String) -> Date {

        let attributes = try! FileManager.default.attributesOfItem(atPath: path)
        return attributes[.creationDate] as! Date
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func modified(path: String) -> Date {

        let attributes = try! FileManager.default.attributesOfItem(atPath: path)
        return attributes[.modificationDate] as! Date
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func size(path: String) -> Int64 {

        let attributes = try! FileManager.default.attributesOfItem(atPath: path)
        return attributes[.size] as! Int64
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func diskFree() -> Int64 {

        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let attributes = try! FileManager.default.attributesOfFileSystem(forPath: path)
        return attributes[.systemFreeSize] as! Int64
    }
}

//Directory
class Dir: NSObject {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func application() -> String {

        return Bundle.main.resourcePath!
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func application(_ component: String) -> String {

        var path = application()

        path = (path as NSString).appendingPathComponent(component)

        return path
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func application(_ component1: String, and component2: String) -> String {

        var path = application()

        path = (path as NSString).appendingPathComponent(component1)
        path = (path as NSString).appendingPathComponent(component2)

        return path
    }

    // MARK: -
    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func document() -> String {

        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func document(_ component: String) -> String {

        var path = document()

        path = (path as NSString).appendingPathComponent(component)

        createIntermediate(path: path)

        return path
    }

    
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func document(_ component1: String, and component2: String) -> String {

        var path = document()

        path = (path as NSString).appendingPathComponent(component1)
        path = (path as NSString).appendingPathComponent(component2)

        createIntermediate(path: path)

        return path
    }

    // MARK: -
    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func cache() -> String {

        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func cache(_ component: String) -> String {

        var path = cache()

        path = (path as NSString).appendingPathComponent(component)

        createIntermediate(path: path)

        return path
    }

    // MARK: -
    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func createIntermediate(path: String) {

        let directory = (path as NSString).deletingLastPathComponent
        if (exist(path: directory) == false) {
            create(directory: directory)
        }
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func create(directory: String) {

        try? FileManager.default.createDirectory(atPath: directory, withIntermediateDirectories: true, attributes: nil)
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func exist(path: String) -> Bool {

        return FileManager.default.fileExists(atPath: path)
    }
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
class DownloadManager: NSObject {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func startUser(_ name: String, pictureAt: Int64, completion: @escaping (_ path: String?, _ error: Error?, _ network: Bool) -> Void) {

		if (pictureAt != 0) {
			start(dir: "user", name: name, ext: "jpg", md5: nil, manual: false, completion: completion)
		} else {
			//completion(nil, NSError.description("Missing picture.", code: 100), false)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func startImage(_ name: String, md5: String?, completion: @escaping (_ path: String?, _ error: Error?, _ network: Bool) -> Void) {

		start(dir: "image", name: name, ext: "jpg", md5: md5, manual: true, completion: completion)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func startVideo(_ name: String, md5: String?, completion: @escaping (_ path: String?, _ error: Error?, _ network: Bool) -> Void) {

		start(dir: "video", name: name, ext: "mp4", md5: md5, manual: true, completion: completion)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func startAudio(_ name: String, md5: String?, completion: @escaping (_ path: String?, _ error: Error?, _ network: Bool) -> Void) {

		start(dir: "audio", name: name, ext: "wav", md5: md5, manual: true, completion: completion)
	}
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func startVoice(_ name: String, md5: String?, completion: @escaping (_ path: String?, _ error: Error?, _ network: Bool) -> Void) {

        start(dir: "voice", name: name, ext: "wav", md5: md5, manual: true, completion: completion)
    }
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func startFile(_ name: String, md5: String?, ext : String, completion: @escaping (_ path: String?, _ error: Error?, _ network: Bool) -> Void) {

        start(dir: "file", name: name, ext: ext, md5: md5, manual: true, completion: completion)
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func startStatusImage(_ name: String, md5: String?, completion: @escaping (_ path: String?, _ error: Error?, _ network: Bool) -> Void) {

        start(dir: "status", name: name, ext: "jpg", md5: md5, manual: true, completion: completion)
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    class func startStatusVideo(_ name: String, md5: String?, completion: @escaping (_ path: String?, _ error: Error?, _ network: Bool) -> Void) {

        start(dir: "status", name: name, ext: "mp4", md5: md5, manual: true, completion: completion)
    }
    
	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	private class func start(dir: String, name: String, ext: String, md5: String?, manual: Bool,
							 completion: @escaping (_ path: String?, _ error: Error?, _ network: Bool) -> Void) {

//		let file = File.name(name, ext)
//		let path = Dir.document(dir, and:file)
//
//		let fileManual = file + ".manual"
//		let pathManual = Dir.document(dir, and:fileManual)
//
//		let fileLoading = file + ".loading"
//		let pathLoading = Dir.document(dir, and:fileLoading)
//
//		let pathStorage = "\(dir)/\(name).\(ext)"
//
//		// Check if file is already downloaded
//		//-----------------------------------------------------------------------------------------------------------------------------------------
//		if (File.exist(path: path)) {
//			completion(path, nil, false)
//			return
//		}
//
//		// Check if manual download is required
//		//-----------------------------------------------------------------------------------------------------------------------------------------
//		if (manual) {
//			if (File.exist(path: pathManual)) {
//				//completion(nil, NSError.description("Manual download required.", code: 101), false)
//				return
//			}
//			try? "manual".write(toFile: pathManual, atomically: false, encoding: .utf8)
//		}
//
//		// Check if file is currently downloading
//		//-----------------------------------------------------------------------------------------------------------------------------------------
//		let time = Int(Date().timeIntervalSince1970)
//
//		if (File.exist(path: pathLoading)) {
//			if let temp = try? String(contentsOfFile: pathLoading, encoding: .utf8) {
//				if let check = Int(temp) {
//					if (time - check < DOWNLOAD_TIMEOUT) {
//						//completion(nil, NSError.description("Downloading.", code: 102), false)
//						return
//					}
//				}
//			}
//		}
//		try? "\(time)".write(toFile: pathLoading, atomically: false, encoding: .utf8)
//
//		// Download the file
//		//-----------------------------------------------------------------------------------------------------------------------------------------
//		let reference = Storage.storage().reference(withPath: pathStorage)
//		reference.write(toFile: URL(fileURLWithPath: path)) { url, error in
//			if (error == nil) {
//				if (File.size(path: path) != 0) {
//					//if (md5 == nil) || (md5 == Checksum.md5HashOf(path: path)) {
//						succeed(dir: dir, name: name, ext: ext, completion: completion)
//					//} else { failed(dir: dir, name: name, ext: ext, error: NSError.description("MD5 error.", code: 103), completion: completion) }
//				} else { //failed(dir: dir, name: name, ext: ext, error: "Length error.", completion: completion)
//
//                }
//			} else { //failed(dir: dir, name: name, ext: ext, error: error, completion: completion)
//
//            }
//		}
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	private class func succeed(dir: String, name: String, ext: String,
							   completion: @escaping (_ path: String?, _ error: Error?, _ network: Bool) -> Void) {

		let file = File.name(name, ext)
		let path = Dir.document(dir, and:file)

		let fileLoading = file + ".loading"
		let pathLoading = Dir.document(dir, and:fileLoading)

		File.remove(path: pathLoading)

		DispatchQueue.main.async {
			completion(path, nil, true)
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private class func failed(dir: String, name: String, ext: String, error: Error?,
							  completion: @escaping (_ path: String?, _ error: Error?, _ network: Bool) -> Void) {

		let file = File.name(name, ext)
		let path = Dir.document(dir, and:file)

		let fileLoading = file + ".loading"
		let pathLoading = Dir.document(dir, and:fileLoading)

		File.remove(path: path)
		File.remove(path: pathLoading)

		DispatchQueue.main.async {
			completion(nil, error, true)
		}
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func pathUser(_ name: String) -> String? { return path(dir: "user", name: name, ext: "jpg") }
	class func pathImage(_ name: String) -> String? { return path(dir: "image", name: name, ext: "jpg") }
	class func pathVideo(_ name: String) -> String? { return path(dir: "video", name: name, ext: "mp4") }
	class func pathAudio(_ name: String) -> String? { return path(dir: "audio", name: name, ext: "wav") }
    class func pathVoice(_ name: String) -> String? { return path(dir: "voice", name: name, ext: "wav") }
    class func pathFile(_ name: String, ext : String) -> String? { return path(dir: "file", name: name, ext: ext) }
    class func pathStatusImage(_ name: String) -> String? { return path(dir: "status", name: name, ext: "jpg") }
    class func pathStatusVideo(_ name: String) -> String? { return path(dir: "status", name: name, ext: "mp4") }
	//---------------------------------------------------------------------------------------------------------------------------------------------

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private class func path(dir: String, name: String, ext: String) -> String? {

		let file = File.name(name, ext)
		let path = Dir.document(dir, and: file)

		return File.exist(path: path) ? path : nil
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func clearManualImage(_ name: String) { clearManual(dir: "image", name: name, ext: "jpg") }
	class func clearManualVideo(_ name: String) { clearManual(dir: "video", name: name, ext: "mp4") }
	class func clearManualAudio(_ name: String) { clearManual(dir: "audio", name: name, ext: "wav") }
    class func clearManualVoice(_ name: String) { clearManual(dir: "voice", name: name, ext: "wav") }
    class func clearManualFile(_ name: String, ext : String) { clearManual(dir: "file", name: name, ext: ext) }
    class func clearManualStatusImage(_ name: String) { clearManual(dir: "status", name: name, ext: "jpg") }
    class func clearManualStatusVideo(_ name: String) { clearManual(dir: "status", name: name, ext: "mp4") }
	//---------------------------------------------------------------------------------------------------------------------------------------------

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private class func clearManual(dir: String, name: String, ext: String) {

		let file = File.name(name, ext)

		let fileManual = file + ".manual"
		let pathManual = Dir.document(dir, and: fileManual)

		let fileLoading = file + ".loading"
		let pathLoading = Dir.document(dir, and:fileLoading)

		File.remove(path: pathManual)
		File.remove(path: pathLoading)
	}

	// MARK: -
	//---------------------------------------------------------------------------------------------------------------------------------------------
	class func saveUser(_ name: String, data: Data)		{ save(data: data, dir: "user", name: name, ext: "jpg", manual: false)	}
	class func saveImage(_ name: String, data: Data)	{ save(data: data, dir: "image", name: name, ext: "jpg", manual: true)	}
	class func saveVideo(_ name: String, data: Data)	{ save(data: data, dir: "video", name: name, ext: "mp4", manual: true)	}
	class func saveAudio(_ name: String, data: Data)	{ save(data: data, dir: "audio", name: name, ext: "wav", manual: true)	}
    class func saveVoice(_ name: String, data: Data)    { save(data: data, dir: "voice", name: name, ext: "wav", manual: true)    }
    class func saveFile(_ name : String, data : Data, ext : String) {
        save(data: data, dir: "file", name: name, ext: ext, manual: true)
    }
    class func saveStatusImage(_ name: String, data: Data)    { save(data: data, dir: "status", name: name, ext: "jpg", manual: true)    }
    class func saveStatusVideo(_ name: String, data: Data)    { save(data: data, dir: "status", name: name, ext: "mp4", manual: true)    }
	//---------------------------------------------------------------------------------------------------------------------------------------------

	//---------------------------------------------------------------------------------------------------------------------------------------------
	private class func save(data: Data, dir: String, name: String, ext: String, manual: Bool) {

		let file = File.name(name, ext)
		let path = Dir.document(dir, and: file)

		let fileManual = file + ".manual"
		let pathManual = Dir.document(dir, and: fileManual)

		try? data.write(to: URL(fileURLWithPath: path), options: .atomic)

		if (manual) {
			try? "manual".write(toFile: pathManual, atomically: false, encoding: .utf8)
		}
	}
}
