package org.garret.perst.impl;

import java.io.IOException;
import java.io.EOFException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import javax.microedition.io.*;
import javax.microedition.io.file.*;

public class RandomAccessFile {
    private FileConnection fconn;
    private InputStream    in;
    private OutputStream   out;
    private long           inPos;
    private long           outPos;
    private long           currPos;
    private long           fileSize;
    private FileDescriptor fd;

    private static final int ZERO_BUF_SIZE = 4096;

    public RandomAccessFile(String path, String mode) throws IOException {
        String url = path;
        if (!url.startsWith("file:")) { 
            if (url.startsWith("/")) { 
                url = "file:///" + path;
            } else { 
                Enumeration e = FileSystemRegistry.listRoots();
                // choose arbitrary root directory
                url = "file:///" + (String)e.nextElement() + url;
            }
        }
        fconn = (FileConnection)Connector.open(url);
        // If no exception is thrown, then the URI is valid, but the file may or may not exist.
        if (!fconn.exists()) { 
            fconn.create();  // create the file if it doesn't exist
        }
        fd = new FileDescriptor(this);
        if (mode.equals("rw")) { 
            out = fconn.openOutputStream();
            outPos = 0;
        }
        fileSize = fconn.fileSize();
        in = null;
        inPos = 0;
        currPos = 0;
    }

    public int read(byte b[], int off, int len) throws IOException {
        if (currPos >= fileSize) { 
            return 0;
        }

        if (in == null || inPos > currPos) { 
            flush(); 
            if (in != null) { 
                in.close();
            }
            in = fconn.openInputStream();
            inPos = in.skip(currPos);
        } else if (inPos < currPos) { 
            inPos += in.skip(currPos - inPos);
        }
        if (inPos != currPos) { 
            return 0;
        }        
        int rc = in.read(b, off, len);
        if (rc > 0) { 
            currPos = inPos += rc;
        }
        return rc;
    }

    public int read(byte b[]) throws IOException {
	return read(b, 0, b.length);
    }

    public void write(byte b[]) throws IOException {
	write(b, 0, b.length); 
    }

    public void write(byte b[], int off, int len) throws IOException {
        if (out == null) { 
            // throw new IllegalModeException();
            throw new IOException("Illegal mode");
        }
        if (outPos != currPos) {                         
            out.close();
            out = fconn.openOutputStream(currPos);
            if (currPos > fileSize) { 
                byte[] zeroBuf = new byte[ZERO_BUF_SIZE];
                do { 
                    int size = currPos - fileSize > ZERO_BUF_SIZE ? ZERO_BUF_SIZE : (int)(currPos - fileSize);
                    out.write(zeroBuf, 0, size);
                    fileSize += size;
                } while (currPos != fileSize);
            }
            outPos = currPos;
        }
        out.write(b, off, len);
	currPos = outPos += len;
        if (currPos > fileSize) { 
            fileSize = currPos;
        }
        if (in != null) { 
            in.close();
            in = null;
        }
    }

    public void seek(long pos) throws IOException {
        currPos = pos;
    }

    public long length() throws IOException { 
        return fileSize;
    }
    
    public long getFilePointer() throws IOException {
        return currPos;
    }

    public void close() throws IOException { 
        if (in != null) { 
            in.close();
            in = null;
        }
        if (out != null) { 
            out.close();
            out = null;
        }
        fconn.close();
    }
    
    public final FileDescriptor getFD() throws IOException {
	return fd;
    }

    public void flush() throws IOException {
        if (out != null) { 
            out.flush();
        }
    }
}
