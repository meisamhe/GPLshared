/*
 * MM JDBC Drivers for MySQL
 *
 * $Id: EscapeTokenizer.java,v 1.2 2000/05/28 18:36:01 mmatthew Exp $
 *
 * Copyright (C) 1998 Mark Matthews <mmatthew@worldserver.com>
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 * 
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA  02111-1307, USA.
 *
 * See the COPYING file located in the top-level-directory of
 * the archive of this library for complete text of license.
 */

/**
 * EscapeTokenizer breaks up an SQL statement into SQL and
 * escape code parts.
 *
 * @author Mark Matthews <mmatthew@worldserver.com>
 */

package org.gjt.mm.mysql;

public class EscapeTokenizer
{
    protected char _last_char = 0;

    protected boolean _in_quotes = false;

    protected boolean _in_braces = false;

    protected char _quote_char = 0;

    protected boolean _emitting_escape_code = false;

    protected String _Source = null;

    protected int _pos = 0;

    public EscapeTokenizer(String S)
    {
	_Source = S;
	_pos = 0;
    }

    public synchronized boolean hasMoreTokens()
    {
	return (_pos < _Source.length());
    }

    public synchronized String nextToken()
    {
	StringBuffer TokenBuf = new StringBuffer();

	if (_emitting_escape_code) {
	    TokenBuf.append("{");
	    _emitting_escape_code = false;
	}

	for (;_pos < _Source.length(); _pos++) {
	    char c = _Source.charAt(_pos);

	    if (c == '\'') {
		if (_last_char != '\\') {
		    if (_in_quotes) {
			if (_quote_char == c) {
			    _in_quotes = false;
			}
		    }
		    else {
			_in_quotes = true;
			_quote_char = c;
		    }
		}
		TokenBuf.append(c);
	    }
	    else if (c == '"') {
		if (_last_char != '\\' && _last_char != '"') {
		    if (_in_quotes) {
			if (_quote_char == c) {
			    _in_quotes = false;
			}
		    }
		    else {
			_in_quotes = true;
			_quote_char = c;
		    }
		}
		TokenBuf.append(c);
	    }
	    else if (c == '{') {
		if (_in_quotes) {
		    TokenBuf.append(c);
		}
		else {
		    _pos++;
		    _emitting_escape_code = true;
		    return TokenBuf.toString();
		}
	    }
	    else if (c == '}') {
		TokenBuf.append(c);
		if (!_in_quotes) {
		    _last_char = c;
		    _pos++;
		    return TokenBuf.toString();
		}
	    }
	    else {
		TokenBuf.append(c);
	    }

	    _last_char = c;
	}

	return TokenBuf.toString();
    }
}
		    
			
	

    
